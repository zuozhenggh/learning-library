// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

vcn_params = {
  ntier = {
    compartment_name = "sandbox"
    display_name     = "ntier"
    vcn_cidr         = "10.0.0.0/16"
    dns_label        = "ntier"
  }
}

igw_params = {
  ntierigw = {
    display_name = "ntierigw" 
    vcn_name     = "ntier"
  }
}

ngw_params = {
  ntierngw = {
    display_name = "ntierngw"
    vcn_name     = "ntier"
  }
}

rt_params = {
  ntier_pub_rt = {
    display_name = "ntier_pub_rt"
    vcn_name     = "ntier"
    route_rules  = [
      {
        destination = "0.0.0.0/0"
        use_igw     = true
        ngw_name    = null
        igw_name    = "ntierigw"
      }
    ]
  }
  ntier_priv_rt = {
    display_name = "ntier_priv_rt"
    vcn_name     = "ntier"
    route_rules  = [
      {
        destination = "0.0.0.0/0"
        use_igw     = false
        ngw_name    = "ntierngw"
        igw_name    = null
      }
    ]
  }
}

sl_params = {
  ntier_pub_sl = {
    vcn_name     = "ntier"
    display_name = "ntier_pub_sl"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      }
    ]

    ingress_rules = [
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"

        tcp_options = [
          {
            min = "22"
            max = "22"
          }
        ]
        udp_options = []
      }
    ]
  }
  ntier_priv_sl = {
    vcn_name     = "ntier"
    display_name = "ntier_priv_sl"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      }
    ]

    ingress_rules = [
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"

        tcp_options = [
          {
            min = "22"
            max = "22"
          }
        ]
        udp_options = []
      }
    ]
  }
}

nsg_params = {}

nsg_rules_params = {}


subnet_params = {
  pubsubnet = {
    display_name      = "pubsubnet"
    cidr_block        = "10.0.1.0/24"
    dns_label         = "pubsubnet"
    is_subnet_private = false
    sl_name           = "ntier_pub_sl"
    rt_name           = "ntier_pub_rt"
    vcn_name          = "ntier"
  }
  privsubnet1 = {
    display_name      = "privsubnet1"
    cidr_block        = "10.0.2.0/24"
    dns_label         = "privsubnet1"
    is_subnet_private = true
    sl_name           = "ntier_priv_sl"
    rt_name           = "ntier_priv_rt"
    vcn_name          = "ntier"
  }
  privsubnet2 = {
    display_name      = "privsubnet2"
    cidr_block        = "10.0.4.0/24"
    dns_label         = "privsubnet2"
    is_subnet_private = true
    sl_name           = "ntier_priv_sl"
    rt_name           = "ntier_priv_rt"
    vcn_name          = "ntier"
  }
}

lpg_params = {}

drg_params = {
  ntier_drg = {
    name      = "ntier_drg"
    vcn_name  = "ntier"
    cidr_rt   = "192.0.0.0/24"
    rt_names  = ["ntier_priv_rt"]
  }
}

ipsec_params = {
  ipsec_connection = {
    comp_name      = "sandbox"
    cpe_ip_address = "140.238.211.235"
    name           = "ipsec_connection"
    drg_name       = "ntier_drg"
    static_routes  = ["10.10.1.0/24"]
  }
}


#------------ Compute --------------
linux_images = {
  ap-mumbai-1    = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa46gx23hrdtxenjyt4p5cc3c4mbvyiqxcb3mmrxnmjn3rfxgvqcma"
  ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaavwjewurl3nvcyq6bgpbrapk4wfwu6qz2ljlrj2yk3cfqexeq64na"
  ap-sydney-1    = "ocid1.image.oc1.ap-sydney-1.aaaaaaaae5qy5o6s2ve2lt4aetmd7s4ydpupowhs6fdl25w4qpkdidbuva5q"
  ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaa54xb7m4f42vckxkrmtlpys32quyjfldbkhq5zsbmw2r6v5hzgvkq"
  ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaagupuj5dfue6gvpmlzzppvwryu4gjatkn2hedocbxbvrtrsmnc5oq"
  eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa3bu75jht762mfvwroa2gdck6boqwyktztyu5dfhftcycucyp63ma"
  eu-zurich-1    = "ocid1.image.oc1.eu-zurich-1.aaaaaaaadx6lizhaqdnuabw4m5dvutmh5hkzoih373632egxnitybcripb2a"
  sa-saopaulo-1  = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa3ke6hsjwdshzoh4mtjq3m6f7rhv4c4dkfljr53kjppvtiio7nv3q"
  uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaasutdhza5wtsrxa236ewtmfa6ixezlaxwxbw7vti2wyi5oobsgoeq"
  us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaox73mjjcopg6damp7tssjccpp5opktr3hwgr63u2lacdt2nver5a"
  us-langley-1   = "ocid1.image.oc2.us-langley-1.aaaaaaaaxyipolnyhfw3t34nparhtlez5cbslyzbvlwxky6ph4mh4s22zmnq"
  us-luke-1      = "ocid1.image.oc2.us-luke-1.aaaaaaaa5dtevrzzxk35dwslew5e6zcqljtfu5hzolcedr467gzuqdg3ls5a"
  us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaauuj2b3bvpbtpcyrfdvxu7tuajrwsmajhn6uhvx4oquecap63jywa"
}

instance_params = {
  vm1 = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "vm1"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "pubsubnet"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "ntier",
      "department" : "ntier"
    }
  }
  vm2 = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "vm2"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "pubsubnet"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "ntier",
      "department" : "ntier"
    }
  }
  vm3 = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "vm3"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "privsubnet1"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "ntier",
      "department" : "ntier"
    }
  }
  vm4 = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "vm4"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "privsubnet1"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "ntier",
      "department" : "ntier"
    }
  }
}

bv_params = {}

windows_images = {
  ap-mumbai-1    = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa4eoqz2o7ssqm63dkzvny5sld5tibr2ynvmyyp6mwoeblfdcjjtkq"
  ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaakb7oq5eiao3rlyha6kf7emogydoy32p3mb22hn3gbwsm7ussfaca"
  ap-sydney-1    = "ocid1.image.oc1.ap-sydney-1.aaaaaaaah4oxmrdqptmcbpdigixfhrxii7rkaspmpq4fppnn3wc6xas2simq"
  ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaagltuwbdjcdfmvj4gkzb7e32g5aedu6yfdzbmmqkxrrv4d7shixia"
  ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaa2iaism6emqvjzgszpnpi7v725herq7u2fdiwswgrplcv4u3g4w6a"
  eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa2rsmgdpbkbo5yrkpynd7mbl5nxpwhyrkp4nd4ev3hzcpfmkosu3q"
  eu-zurich-1    = "ocid1.image.oc1.eu-zurich-1.aaaaaaaawo4g3t6s34okuj7huyrixkucmxtfaqeiqhvsfiok4gxhe3pdpmaa"
  sa-saopaulo-1  = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaanunxttcfebrg3t34jupfsiy2dqry4wkoaak5h3pckpitylzm44qq"
  uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaaanixvr63v5v5vvz5qv2c73m6vvc6okwrrqggfvqthyygalm536ra"
  us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaizov2horgjtlxsklhi3cxxjxbcpxzxmtfj5jiftygo76fetussuq"
  us-langley-1   = "ocid1.image.oc2.us-langley-1.aaaaaaaafiwiumrgcipjddg7cha7otxo46dd5hiw7za5llbwnugrgclxqbga"
  us-luke-1      = "ocid1.image.oc2.us-luke-1.aaaaaaaaelf7bq6rtwsxhvkjh6eumoa77ebniwkbyntfti5gtkgvwqnk6dsq"
  us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaatte3vcpa7kkogul7zbvnxfjsgwzptmbx7n7qqrzk62skron5on7a"
}

win_instance_params = {}

win_bv_params = {}
#-----------------------------------

#-------------- DBaaS --------------
database_params = {
  ntierdb = {
    compartment_name        = "sandbox"
    ad                      = 1
    cpu_core_count          = 2
    db_edition              = "ENTERPRISE_EDITION"
    db_name                 = "ntierdb"
    db_admin_password       = "BEstrO0ng_#11"
    db_workload             = "OLTP"
    pdb_name                = "cust1pdb"
    enable_auto_backup      = true
    db_version              = "12.1.0.2"
    display_name            = "ntierdb"
    disk_redundancy         = "HIGH"
    shape                   = "VM.Standard2.8"
    subnet_name             = "privsubnet2"
    ssh_public_key          = "/root/.ssh/id_rsa.pub"
    hostname                = "ntierdb"
    data_storage_size_in_gb = 256
    license_model           = "BRING_YOUR_OWN_LICENSE"
    node_count              = 1
  }
}



lb_params = {
  ntier_pub_lb = {
    shape            = "100Mbps"
    compartment_name = "sandbox"
    subnet_names     = ["pubsubnet"]
    display_name     = "ntier_pub_lb"
    is_private       = false
  }
  ntier_priv_lb = {
    shape            = "100Mbps"
    compartment_name = "sandbox"
    subnet_names     = ["privsubnet1"]
    display_name     = "ntier_priv_lb"
    is_private       = true
  }
}

backend_sets = {
  ntier_pub_bs = {
    name        = "ntier_pub_bs"
    lb_name     = "ntier_pub_lb"
    policy      = "ROUND_ROBIN"
    hc_port     = 80
    hc_protocol = "HTTP"
    hc_url      = "/"
  }
  ntier_priv_bs = {
    name        = "ntier_priv_bs"
    lb_name     = "ntier_priv_lb"
    policy      = "ROUND_ROBIN"
    hc_port     = 80
    hc_protocol = "HTTP"
    hc_url      = "/"
  }
}

listeners = {
  ntier_pub_list = {
    lb_name          = "ntier_pub_lb"
    name             = "ntier_pub_list"
    backend_set_name = "ntier_pub_bs"
    port             = 80
    protocol         = "HTTP"
    ssl              = []
  }
  ntier_priv_list = {
    lb_name          = "ntier_priv_lb"
    name             = "ntier_priv_list"
    backend_set_name = "ntier_priv_bs"
    port             = 80
    protocol         = "HTTP"
    ssl              = []
  }
}

backend_params = {
  vm1 = {
    backendset_name = "ntier_pub_bs"
    use_instance    = true
    instance_name   = "vm1"
    lb_name         = "ntier_pub_lb"
    port            = 80
    lb_backend_name = ""
  }
  vm2 = {
    backendset_name = "ntier_pub_bs"
    use_instance    = true
    instance_name   = "vm2"
    lb_name         = "ntier_pub_lb"
    port            = 80
    lb_backend_name = ""
  }
  vm3 = {
    backendset_name = "ntier_priv_bs"
    use_instance    = true
    instance_name   = "vm3"
    lb_name         = "ntier_priv_lb"
    port            = 80
    lb_backend_name = ""
  }
  vm4 = {
    backendset_name = "ntier_priv_bs"
    use_instance    = true
    instance_name   = "vm4"
    lb_name         = "ntier_priv_lb"
    port            = 80
    lb_backend_name = ""
  }
}

certificates = {}
