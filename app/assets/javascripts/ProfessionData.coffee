define [
], () ->



  JOBTITLE_SYSTEMS = {
    "CCP": [
      {
        id: "ECN"
        name: "Employee/Contractor Number"
        status: "Complete"
        prereq: "None"
      },
      {
        id: "ADS"
        name: "Active Directory Service"
        status: "Requested"
        prereq: "ECN"
      }
      {
        id: "Badge"
        name: "Building Access"
        status: "Requested"
        prereq: "ECN"
      }
      {
        id: "email"
        name: "E-Mail"
        status: "Pending"
        prereq: "ADS"
      }
      {
        id: "Desktop+"
        name: "Desktop+"
        status: "Pending"
        prereq: "ARNZ, CAS, Globestar, WCC/CC90s"
      }
      {
        id: "ARNZ"
        name: "ARNZ"
        status: "Pending"
        prereq: "ADS"
      }
      {
        id: "CAS"
        name: "Credit Authorisation Service"
        status: "Pending"
        prereq: "ADS"
      }
      {
        id: "GS"
        name: "Globestar"
        status: "Pending"
        prereq: "ADS"
      }
      {
        id: "WCC"
        name: "WCC/CC90s"
        status: "Pending"
        prereq: "ADS"
      }
      {
        id: "Compass"
        name: "Compass"
        status: "Pending"
        prereq: "ADS"
      }
      {
        id: "STAR"
        name: "STAR"
        status: "Pending"
        prereq: "ADS"
      }
      {
        id: "XNET"
        name: "XNET"
        status: "Pending"
        prereq: "ADS"
      }
    ]
  }

  ALL_SYSTEMS = [
    {
      id: "ECN",
      name: "Employee/Contractor Number"
      prereq: "None"
    },
    {
      id: "ADS",
      name: "Active Directory Service"
      prereq: "ECN"
    }
    {
      id: "Desktop+",
      name: "Desktop+"
      prereq: "ARNZ, CAS, Globestar, WCC/CC90s"
    }
    {
      id: "Actuate",
      name: "Actuate"
      prereq: "ADS"
    }
    {
      id: "ARNZ",
      name: "ARNZ"
      prereq: "ADS"
    }
    {
      id: "Badge",
      name: "Building Access"
      prereq: "ECN"
    }
    {
      id: "CAS",
      name: "Credit Authorisation Service"
      prereq: "ADS"
    }
    {
      id: "CMS",
      name: "CMS Supervisor"
      prereq: "ADS"
    }
    {
      id: "Compass",
      name: "Compass"
      prereq: "ADS"
    }
    {
      id: "email",
      name: "E-Mail"
      prereq: "ADS"
    }
    {
      id: "GS",
      name: "Globe Star"
      prereq: "ADS"
    }
    {
      id: "IDN",
      name: "Information Delivery Network"
      prereq: "ADS"
    }
    {
      id: "MicroStrategy",
      name: "MicroStrategy"
      prereq: "ADS"
    }
    {
      id: "STAR",
      name: "STAR"
      prereq: "ADS"
    }
    {
      id: "WCC",
      name: "WCC/CC90s"
      prereq: "ADS"
    }
    {
      id: "XNET",
      name: "XNET"
      prereq: "ADS"
    }
  ]



  ##
  # The available managers
  ##
  MANAGERS = [
    {id: "RutterRoyce", name: "Royce G Rutter"},
    {id: "CamidgeIsabella", name: "Isabella Camidge"},
    {id: "McFarlandKatie", name: "Katie McFarland"},
    {id: "NiuZi", name: "Zi Niu"},
    {id: "WuFeng", name: "Feng Wu"},
    {id: "PetersJonathan", name: "Jonathan Peters"},
    {id: "GarnerCharlie", name: "Charlie Garner"}
  ]

  ##
  # The cost center that will be assigned to any employees
  # under the specified manager
  ##
  CC_BY_MANAGERS = {
    RutterRoyce: [
      {id: "CC1", name: "412998984"}
    ]
    CamidgeIsabella: [
      {id: "CC2", name: "788724797"}
    ]
    McFarlandKatie: [
       {id: "CC3", name: "981532610"}
    ]
    NiuZi: [
       {id: "CC4", name: "337274591"}
    ]
    WuFeng: [
       {id: "CC5", name: "246053055"}
    ]
    PetersJonathan: [

       {id: "CC6", name: "993722183"}
    ]
    GarnerCharlie: [
       {id: "CC7", name: "867235839"}
    ]
  }

  ##
  # The list of job titles
  ##
  JOBTITLE = [
    {id: "CCP", name: "Customer Care Professional"},
    {id: "AstMgr", name: "Assistant Manager - Retention"},
    {id: "BA", name: "Business Analyst"},
    {id: "PM", name: "Project Manager"},
    {id: "RM", name: "Relationship Manager"},
    {id: "EA", name: "Executive Assistant"},
    {id: "TL", name: "Team Leader"}
  ]

  ##
  # The list of job title IDs associated with managers
  ##
  JOBTITLE_BY_MANAGERS = {
    RutterRoyce: [
      "CCP", "RM", "TL"
    ]
    CamidgeIsabella: [
      "BA", "PM"
    ]
    McFarlandKatie: [
      "EA", "AstMgr"
    ]
    NiuZi: [
      "CCP", "TL"
    ]
    WuFeng: [
      "BA", "PM", "EA"
    ]
    PetersJonathan: [
      "RM", "BA", "TL"
    ]
    GarnerCharlie: [
      "CCP", "RM", "TL", "EA", "BA"
    ]
  }

  ##
  # Provide access to the data
  ##
  class DataAccess

    roles: () -> JOBTITLE_SYSTEMS

    systems: () -> ALL_SYSTEMS

    getManagers: () -> MANAGERS

    getJobTitles: () -> JOBTITLE

    getRoleTemplates: () -> ROLE_TEMPLATE


    ##
    # return the job titles associated with the given manager
    ##
    getJobTitle: (managerId) ->
      titleId = JOBTITLE_BY_MANAGERS[managerId][0]
      for title in JOBTITLE
        if title.id == titleId
          return title

    ##
    # return the cost center associated with the given manager
    ##
    getCostCenter: (managerId) ->
      CC_BY_MANAGERS[managerId][0]


  return new DataAccess()