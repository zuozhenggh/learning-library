// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

vcn_params = {
  customer1 = {
    compartment_name = "sandbox"
    display_name     = "customer1"
    vcn_cidr         = "10.0.0.0/16"
    dns_label        = "customer1"
  }
  customer2 = {
    compartment_name = "sandbox"
    display_name     = "customer2"
    vcn_cidr         = "11.0.0.0/16"
    dns_label        = "customer2"
  }
}

igw_params = {
  customer1 = {
    display_name = "customer1"
    vcn_name     = "customer1"
  }
  customer2 = {
    display_name = "customer2"
    vcn_name     = "customer2"
  }
}

ngw_params = {}

rt_params = {
  customer1_pub_rt = {
    display_name = "customer1_pub_rt"
    vcn_name     = "customer1"
    route_rules  = [
      {
        destination = "0.0.0.0/0"
        use_igw     = true
        ngw_name    = null
        igw_name    = "customer1"
      }
    ]
  }
  customer1_priv_rt = {
    display_name = "customer1_priv_rt"
    vcn_name     = "customer1"
    route_rules  = []
  }

  customer2_pub_rt = {
    display_name = "customer2_pub_rt"
    vcn_name     = "customer2"
    route_rules  = [
      {
        destination = "0.0.0.0/0"
        use_igw     = true
        ngw_name    = null
        igw_name    = "customer2"
      }
    ]
  }
  customer2_priv_rt = {
    display_name = "customer2_priv_rt"
    vcn_name     = "customer2"
    route_rules  = []
  }
}

sl_params = {
  customer1_pub_sl = {
    vcn_name     = "customer1"
    display_name = "customer1_pub_sl"

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
        protocol    = "all"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"

        tcp_options = []
        udp_options = []
      }
    ]
  }
  customer1_priv_sl = {
    vcn_name     = "customer1"
    display_name = "customer1_priv_sl"

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
  customer2_pub_sl = {
    vcn_name     = "customer2"
    display_name = "customer2_pub_sl"

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
        protocol    = "all"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"

        tcp_options = []
        udp_options = []
      }
    ]
  }
  customer2_priv_sl = {
    vcn_name     = "customer2"
    display_name = "customer2_priv_sl"

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
  subnet1A = {
    display_name      = "subnet1A"
    cidr_block        = "10.0.1.0/24"
    dns_label         = "subnet1a"
    is_subnet_private = false
    sl_name           = "customer1_pub_sl"
    rt_name           = "customer1_pub_rt"
    vcn_name          = "customer1"
  }
  subnet1B = {
    display_name      = "subnet1B"
    cidr_block        = "10.0.2.0/24"
    dns_label         = "subnet1b"
    is_subnet_private = true
    sl_name           = "customer1_priv_sl"
    rt_name           = "customer1_priv_rt"
    vcn_name          = "customer1"
  }
  subnet2A = {
    display_name      = "subnet2A"
    cidr_block        = "11.0.1.0/24"
    dns_label         = "subnet2a"
    is_subnet_private = false
    sl_name           = "customer2_pub_sl"
    rt_name           = "customer2_pub_rt"
    vcn_name          = "customer2"
  }
  subnet2B = {
    display_name      = "subnet2B"
    cidr_block        = "11.0.2.0/24"
    dns_label         = "subnet1b"
    is_subnet_private = true
    sl_name           = "customer2_priv_sl"
    rt_name           = "customer2_priv_rt"
    vcn_name          = "customer2"
  }
}

lpg_params = {}

drg_params = {
  customer1_drg = {
    name      = "customer1_drg"
    vcn_name  = "customer1"
    cidr_rt   = "13.0.0.0/24"
    rt_names  = ["customer1_priv_rt"]
  }
  customer2_drg = {
    name      = "customer2_drg"
    vcn_name  = "customer2"
    cidr_rt   = "12.0.0.0/24"
    rt_names  = ["customer2_priv_rt"]
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
  customer1a = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "customer1a"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = true
    compartment_name     = "sandbox"
    subnet_name          = "subnet1A"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer1",
      "department" : "customer1"
    }
  }
  customer1b = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "customer1b"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "subnet1B"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer1",
      "department" : "customer1"
    }
  }
  customer2a = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "customer2a"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = true
    compartment_name     = "sandbox"
    subnet_name          = "subnet2A"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer2",
      "department" : "customer2"
    }
  }
  customer2b = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "customer2b"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "subnet2B"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer1",
      "department" : "customer1"
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
  cust1db = {
    compartment_name        = "sandbox"
    ad                      = 1
    cpu_core_count          = 2
    db_edition              = "ENTERPRISE_EDITION"
    db_name                 = "cust1db"
    db_admin_password       = "BEstrO0ng_#11"
    db_workload             = "OLTP"
    pdb_name                = "cust1pdb"
    enable_auto_backup      = true
    db_version              = "12.1.0.2"
    display_name            = "customer1db"
    disk_redundancy         = "HIGH"
    shape                   = "VM.Standard2.8"
    subnet_name             = "subnet1B"
    ssh_public_key          = "/root/.ssh/id_rsa.pub"
    hostname                = "cust1db"
    data_storage_size_in_gb = 256
    license_model           = "BRING_YOUR_OWN_LICENSE"
    node_count              = 1
  }
  cust2db = {
    compartment_name        = "sandbox"
    ad                      = 1
    cpu_core_count          = 2
    db_edition              = "ENTERPRISE_EDITION"
    db_name                 = "cust2db"
    db_admin_password       = "BEstrO0ng_#11"
    db_workload             = "OLTP"
    pdb_name                = "cust2pdb"
    enable_auto_backup      = true
    db_version              = "12.1.0.2"
    display_name            = "customer2db"
    disk_redundancy         = "NORMAL"
    shape                   = "VM.Standard2.8"
    subnet_name             = "subnet2B"
    ssh_public_key          = "/root/.ssh/id_rsa.pub"
    hostname                = "cust2db"
    data_storage_size_in_gb = 256
    license_model           = "BRING_YOUR_OWN_LICENSE"
    node_count              = 1
  }
}



lb_params = {
  customer1lb = {
    shape            = "100Mbps"
    compartment_name = "sandbox"
    subnet_names     = ["subnet1A"]
    display_name     = "customer1lb"
    is_private       = false
  }
  customer2lb = {
    shape            = "100Mbps"
    compartment_name = "sandbox"
    subnet_names     = ["subnet2A"]
    display_name     = "customer2lb"
    is_private       = false
  }
}

backend_sets = {
  customer1bs = {
    name        = "customer1bs"
    lb_name     = "customer1lb"
    policy      = "ROUND_ROBIN"
    hc_port     = 80
    hc_protocol = "HTTP"
    hc_url      = "/"
  }
  customer2bs = {
    name        = "customer2bs"
    lb_name     = "customer2lb"
    policy      = "ROUND_ROBIN"
    hc_port     = 80
    hc_protocol = "HTTP"
    hc_url      = "/"
  }
}

listeners = {
  customer1list = {
    lb_name          = "customer1lb"
    name             = "customer1list"
    backend_set_name = "customer1bs"
    port             = 80
    protocol         = "HTTP"
    ssl              = []
  }
  customer2list = {
    lb_name          = "customer2lb"
    name             = "customer2list"
    backend_set_name = "customer2bs"
    port             = 80
    protocol         = "HTTP"
    ssl              = []
  }
}

backend_params = {
  cust1bsA = {
    backendset_name = "customer1bs"
    use_instance    = true
    instance_name   = "customer1a"
    lb_name         = "customer1lb"
    port            = 80
    lb_backend_name = ""
  }
  cust1bsB = {
    backendset_name = "customer1bs"
    use_instance    = true
    instance_name   = "customer1b"
    lb_name         = "customer1lb"
    port            = 80
    lb_backend_name = ""
  }
  cust2bsA = {
    backendset_name = "customer2bs"
    use_instance    = true
    instance_name   = "customer2a"
    lb_name         = "customer2lb"
    port            = 80
    lb_backend_name = ""
  }
  cust2bsB = {
    backendset_name = "customer2bs"
    use_instance    = true
    instance_name   = "customer2b"
    lb_name         = "customer2lb"
    port            = 80
    lb_backend_name = ""
  }
}

certificates = {}

ipsec_params = {
  ipsec_customer1 = {
    comp_name      = "sandbox"
    cpe_ip_address = "140.238.211.235"
    name           = "ipsec_customer1"
    drg_name       = "customer1_drg"
    static_routes  = ["10.0.0.0/24"]
  }
  ipsec_customer2 = {
    comp_name      = "sandbox"
    cpe_ip_address = "140.238.211.235"
    name           = "ipsec_customer2"
    drg_name       = "customer2_drg"
    static_routes  = ["11.0.0.0/24"]
  }
}


cc_group = {
  ccgrp1 = {
    comp_name = "sandbox"
    name      = "ccgrp1"
  }
}
cc = {
  cc1 = {
    comp_name             = "sandbox"
    name                  = "cc1"
    cc_group_name         = "ccgrp1"
    location_name         = "Chandler"
    port_speed_shape_name = "10Gbps"
  }
}

private_vc_no_provider = {
  priv_vc_no_provider = {
    comp_name             = "sandbox"
    name                  = "priv_vc_no_provider"
    type                  = "PRIVATE"
    bw_shape              = "10Gbps"
    cc_group_name         = "ccgrp1"
    cust_bgp_peering_ip   = "10.0.0.18/31"
    oracle_bgp_peering_ip = "10.0.0.18/31"
    vlan                  = "200"
    drg                   = "customerB_drg"
  }
}
private_vc_with_provider = {}
public_vc_no_provider    = {}
public_vc_with_provider  = {}
