# Creating a Micro-Service and Frontend

## Intro

Up until now we invoked our function from command line and via events. Time
for a Web Frontend.

## Understanding API Gateway

API Gateway provides public access to private APIs. It provides different
features like rate limiting or authentication to protect your application.

You find the *API Gateway* in the menu unter *Developer Services* right
below *Functions* we visited before.

TODO Menu screenshot

Our Setup already created a Gateway called *DemoApp*. Click on it. A single
Gateway can contain multiple Deployments. To find the Deployment the setup
generated click on *Deployments* in the Resources menu on the left and
click on the deployment *apideployment2020....*.

A Deployment is a set of routes from the frontend to a backend service.
Your Deployment's public Endpoint URL can be found on the Deployment page top
right.

TODO Screenshot

In this deployment we have a preconfigured route. To see it click *Edit* and
then *Routes* on the left.

TODO Screenshot

In there the path `/` is being forwarded to a file in the object storage. This
is what the `htmlpages` *Bucket* is for we saw while exploring the Object Store
in the previous Lab.

Alright, let's try it out. Click *Cancel* to go back and copy the Endpoint
URL, which looks like `https://bfds.....apigateway.us-ashburn-1.oci.customer-oci.com/node_mysql`
into a new browser tab. And ... you will get an JSON file with a 404 error.

Reason is that our route is called `/` so you have to append a `/` to the URL
after the `node_mysql`. Now a Website with two buttons should appear. If you
click those you'll receive errors as the services feeding data haven't been
provided yet. You can use your browser's "View Source" feature or download
the file from object store to look at our frontend's code. We won't go
through the code here in detail, but it should become obvious once we
put life into it by creating the backend service.

Time to create a new Function.

*Note: If you consider the URL ugly you could use your own domain name after
providing a TLS certificate. We will skip that here.*

## Our first Document Search

    const fdk = require('@fnproject/fdk');
    const mysqlx = require('@mysql/xdevapi');
    const date = require('./date');

    fdk.handle(async function(input, ctx) {
        const { config, headers } = ctx;

        const session = await mysqlx.getSession({
            host: config.mysql_host,
            port: config.mysql_port,
            user: config.mysql_user,
            password: config.mysql_pass,
        });
        const people = session.getSchema(config.mysql_schema).getCollection('people');

        try {
            if (headers['Fn-Http-H-X-Mode'][0] == 'state') {
                const result = await people
                    .find('city.state = :value')
                    .bind('value', headers['Fn-Http-H-X-Value'][0])
                    .execute();
                return result.fetchAll();
            } else {
                throw new Error(`Unknown mode ${headers['Fn-X-Mode'][0]}`);
            }
        } catch (err) {
            const hctx = ctx.httpGateway;
            hctx.statusCode = 500;
            return { success: false, err: err.message, stack: err.stack };
        } finally {
            session.close();
        }
    });


## Using SQL for advanced queries

            } else if (headers['Fn-Http-H-X-Mode'][0] == 'salary') {
                const result = await session.sql(
                    `SELECT doc
                       FROM ${config.mysql_schema}.people
                      WHERE JSON_EXTRACT(doc,
                                 CONCAT('$.salary_history[', JSON_LENGTH(doc->'$.salary_history')-1, '].salary')
                            ) > ?`
                    ).bind(1*headers['Fn-Http-H-X-Value'][0]).execute();
                return result.fetchAll().map(row => row[0]);
            }

## Updating Documents


            } else if (headers['Fn-Http-H-X-Mode'][0] == 'raisesalary') {
                const id = headers['Fn-Http-H-X-Id'][0];
                const raise = input.amount;
    
                if (raise <= 0) {
                    throw new Error(`We do only positive raises here! (Value: ${raise})`);
                }
    
               session.startTransaction();
               const old = await people.getOne(id);
               const oldSalary = old.salary_history[old.salary_history.length - 1].salary;
               const newEntry = { salary: oldSalary + raise, date: date() };
     
               await people
                   .modify('_id = :id')
                   .arrayAppend('salary_history', newEntry)
                   .bind('id', id)
                   .execute();

               await session.commit();
               return { success: true, newEntry };
            }

ddd
