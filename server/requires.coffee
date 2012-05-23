dateformat = __meteor_bootstrap__.require "dateformat"

ldapjs = __meteor_bootstrap__.require "ldapjs"

ldap_client = ldapjs.createClient
  url: ChatroomConfig.ldap.url
