// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

vcn_params = {
  mgmt_vcn = {
    compartment_name = "sandbox"
    display_name     = "mgmt_vcn"
    vcn_cidr         = "10.0.0.0/16"
    dns_label        = "mgmtvcn"
  }
  customerA_vcn = {
    compartment_name = "sandbox"
    display_name     = "customerA_vcn"
    vcn_cidr         = "10.10.0.0/16"
    dns_label        = "customeravcn"
  }
  customerB_vcn = {
    compartment_name = "sandbox"
    display_name     = "customerB_vcn"
    vcn_cidr         = "10.20.0.0/16"
    dns_label        = "customerbvcn"
  }

}

igw_params = {}

ngw_params = {}

rt_params = {
  mgmt_rt = {
    display_name = "mgmt_rt"
    vcn_name     = "mgmt_vcn"
    route_rules  = []
  }

  customerA_rt = {
    display_name = "customerA_rt"
    vcn_name     = "customerA_vcn"
    route_rules  = []
  }

  customerB_rt = {
    display_name = "customerB_rt"
    vcn_name     = "customerB_vcn"
    route_rules  = []
  }
}

sl_params = {
  mgmt_sl = {
    vcn_name     = "mgmt_vcn"
    display_name = "mgmt_sl"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      },
    ]

    ingress_rules = [
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"
        tcp_options = []
        udp_options = []
      }
    ]
  }
  customerA_sl = {
    vcn_name     = "customerA_vcn"
    display_name = "customerA_sl"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      },
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
  customerB_sl = {
    vcn_name     = "customerB_vcn"
    display_name = "customerB_sl"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      },
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
  sharedsubnet = {
    display_name      = "sharedsubnet"
    cidr_block        = "10.0.0.0/24"
    dns_label         = "sharedsubnet"
    is_subnet_private = false
    sl_name           = "mgmt_sl"
    rt_name           = "mgmt_rt"
    vcn_name          = "mgmt_vcn"
  }
  appsubneta = {
    display_name      = "appsubneta"
    cidr_block        = "10.10.0.0/24"
    dns_label         = "appsubneta"
    is_subnet_private = true
    sl_name           = "customerA_sl"
    rt_name           = "customerA_rt"
    vcn_name          = "customerA_vcn"
  }
  appsubnetb = {
    display_name      = "appsubnetb"
    cidr_block        = "10.20.0.0/24"
    dns_label         = "appsubnetb"
    is_subnet_private = true
    sl_name           = "customerB_sl"
    rt_name           = "customerB_rt"
    vcn_name          = "customerB_vcn"
  }
}

lpg_params = {
  mgmt_to_a = {
    requestor    = "mgmt_vcn"
    acceptor     = "customerA_vcn"
    display_name = "mgmt_to_a"
  }
  mgmt_to_b = {
    requestor    = "mgmt_vcn"
    acceptor     = "customerB_vcn"
    display_name = "mgmt_to_b"
  }
}

drg_params = {
  mgmt_drg = {
    name      = "mgmt_drg"
    vcn_name  = "mgmt_vcn"
    cidr_rt   = "192.0.0.0/16"
    rt_names  = ["mgmt_rt"]
  }
  customerA_drg ={
    name      = "customerA_drg"
    vcn_name  = "customerA_vcn"
    cidr_rt   = "192.10.0.0/16"
    rt_names  = ["customerA_rt"]
  }
  customerB_drg ={
    name      = "customerB_drg"
    vcn_name  = "customerB_vcn"
    cidr_rt   = "192.20.0.0/16"
    rt_names  = ["customerB_rt"]
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
  mgmt1 = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "mgmt1"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "sharedsubnet"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "mgmt",
      "department" : "mgmt"
    }
  }
  mgmt2 = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "mgmt2"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "sharedsubnet"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "mgmt",
      "department" : "mgmt"
    }
  }
  ca1 = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "ca1"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "appsubneta"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer a",
      "department" : "customer a"
    }
  }
  ca2 = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "ca2"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "appsubneta"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer a",
      "department" : "customer a"
    }
  }
  cb1 = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "cb1"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "appsubnetb"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer b",
      "department" : "customer b"
    }
  }
  cb2 = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "cb2"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "appsubnetb"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer b",
      "department" : "customer b"
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

ipsec_params = {
  ipsec_customer_a = {
    comp_name      = "sandbox"
    cpe_ip_address = "140.238.211.235"
    name           = "ipsec_customer_a"
    drg_name       = "customerA_drg"
    static_routes  = ["10.20.0.0/24"]
  }
  ipsec_mgmt_vcn = {
    comp_name      = "sandbox"
    cpe_ip_address = "140.238.211.235"
    name           = "ipsec_mgmt_vcn"
    drg_name       = "mgmt_drg"
    static_routes  = ["10.0.0.0/24"]
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