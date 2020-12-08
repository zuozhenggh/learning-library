"use strict";

// document.ready function
$(() => {
    $('#lastmodified').text(document.lastModified); //sets the value for the last modified date in the HTML output

    $('#main').bind('input propertychange', '#htmlBox', e => { //event listener for updating the right side HTML view when the MD box text is changed
        if ($('#htmlBox').length !== 0) {
            showMdInHtml();
        }
    });

    $('#main').on('click', '#import_html', function () { //event listener for import HTML
        $('#upload_html').click();
    });
    $('#main').on('change', '#upload_html', enterHTMLData); //event listener for upload HTML
});

//displays the MD content in HTML
let showMdInHtml = () => {
    let turndownService = new TurndownService({headingStyle: 'atx', hr: '', bulletListMarker: '-'});

    turndownService.addRule('codeblock', {
        filter: ['pre'],
        replacement: function (content) {
          return '\n```\n' + content + '\n```'
        }
    });

    turndownService.remove(['head', 'title', 'script', 'noscript', 'wrapper', 'header', 'footer', 'figcaption', 'button']);
    $('#mdBox').val(turndownService.turndown(customRule($('#htmlBox').val())).trim());
}

let customRule = (html) => {
    let doc = document.createElement('html');
    $(doc).html(html);

    $(doc).find('h1 img').remove();
    $(doc).find('h2 img').remove();
    $(doc).find('.modal').remove();

    console.log(doc);
    return doc;

}

let enterHTMLData = evt => {
    let files = evt.target.files;
    let file = files[0];
    let reader = new FileReader();
    let md;
    reader.onload = (function (theFile) {
        return function (e) {
            md = e.target.result;
        };
    })(file);
    reader.onloadend = function () {
        $('#htmlBox').val(md);
        $('#htmlBox').trigger('input');
    }
    $('#upload_html').val("");
    reader.readAsText(file);
}