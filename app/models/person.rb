require 'net/ldap'

class Person < ActiveRecord::Base

  # === List of columns ===
  #   id                  : integer 
  #   first_name          : string 
  #   last_name           : string 
  #   username            : string 
  #   email               : string 
  #   crypted_password    : string 
  #   password_salt       : string 
  #   persistence_token   : string 
  #   single_access_token : string 
  #   perishable_token    : string 
  #   phone_number        : string 
  #   aim                 : string 
  #   date_of_birth       : date 
  #   created_at          : datetime 
  #   updated_at          : datetime 
  # =======================

  acts_as_authentic do |c|
    # Options go here if you have any
  end

  def valid_ldap_or_password?(password)
    return valid_ldap?(password) || valid_password?(password)
  end

  def valid_ldap?(password)
    ldap = Net::LDAP.new( :host => LDAP_SERVER, :port => LDAP_SERVER_PORT )
    a = ldap.bind( :method => :simple, :username => "uid=#{username}, ou=people, dc=hkn, dc=eecs, dc=berkeley, dc=edu", :password => password )
    puts "LDAP RESULT: #{a}"
    return a
  end
end