# Examples and Exercises

.fx: titleslide


## presenter notes
For convenience in working with examples we will use the [autorun]() feature
from the masterfiles policy framework.

* Autorun bundles are executed in lexical order. Use digit prefixes to get
  specific ordering.

---
## Enable services_autorun
    !shell
    [root@hub masterfiles]# cat > def.json <<EOF
    {
        "classes": {
            "cfengine_internal_masterfiles_update": [
                "policy_server"
            ],
            "services_autorun": [ "any" ]
        }
    }
    EOF

---
## Inspect
    !shell
    [root@hub masterfiles]# git status
    # On branch master
    # Changes not staged for commit:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #	modified:   def.json
    #
    no changes added to commit (use "git add" and/or "git commit -a")

---
## What you expect
    !shell
    [root@hub masterfiles]# git diff
    diff --git a/def.json b/def.json
    index 0b1c721..bf3b515 100644
    --- a/def.json
    +++ b/def.json
    @@ -1 +1,8 @@
    -{ "classes": { "cfengine_internal_masterfiles_update": [ "policy_server" ] } }
    +{   
    +    "classes": {
    +        "cfengine_internal_masterfiles_update": [
    +            "policy_server"
    +        ],  
    +        "services_autorun": [ "any" ]
    +    }   
    +}   

---
## Publish the change
    !shell
    [root@hub masterfiles]# git add def.json 
    [root@hub masterfiles]# git commit -m "Enable autorun"
    [master 7e57301] Enable autorun
     1 file changed, 8 insertions(+), 1 deletion(-)
    [root@hub masterfiles]# git push origin master
    Counting objects: 5, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (3/3), done.
    Writing objects: 100% (3/3), 364 bytes | 0 bytes/s, done.
    Total 3 (delta 1), reused 0 (delta 0)
    To /opt/cfengine/masterfiles.git
       c206654..7e57301  master -> master

---
## Example - Create a file
Copy this example to `services/autorun/nologin.cf`

    !cf3
    # examples/00-20-example-create_file.cf
    bundle agent no_login
    {
      meta:
        "tags" slist => { "autorun" };

      files:
          "/etc/nologin"
            create => "true";
    }

---
## Example - update file
    !cf3
    # examples/00-20-example-update_file.cf
    bundle agent cf_agent_heartbeat
    {
      meta:
        "tags" slist => { "autorun" };

      files:
        "$(sys.statedir)/$(this.bundle)" -> { "Monitoring" }
          create  => "true",
          touch   => "true",
          classes => scoped_classes_generic("bundle", "heartbeat"),
          handle  => "cf_agent_heartbeat_thump",
          comment => "This policy simply updates the timestamp
                      of the file so an external monitoring
                      system can validate the system is working.";

      reports:
        DEBUG|DEBUG_cf_agent_heartbeat::

          "DEBUG $(this.bundle): Heartbeat"
            if => "heartbeat_repaired";

          "DEBUG $(this.bundle): Flatline"
            unless => "heartbeat_repaired";
    }

---
## Exercise - create a file
Write a policy that ensures /etc/cron.allow is present so that only users
listed in the file are allowed to schedule jobs.

Test with `crontab -e`

---
## Example - install a package and start a service
    !cf3
    # examples/00-20-example-package_and_service.cf
    bundle agent training_simple_website
    {
      meta:
        host001::
          "tags" slist => { "autorun" };

      packages:
          "httpd"
            policy => "present",
            package_module => yum;

      services:
          "httpd"
            service_policy => "start";

      reports:
        DEBUG|DEBUG_training_simple_website::
          "DEBUG $(this.bundle)";
    }

---
## Example - Classify role based on hostname
    !cf3
    # examples/00-20-example-classes-role_by_hostname.cf
    bundle common classes_role_by_hostname
    {
      classes:
        "env_prod"
          meta => { "inventory", "attribute_name=Role Classes" };
          or => {
                  regcmp( "hub", $(sys.fqhost) ), 
                  regcmp( "^prd.*", $(sys.fqhost) ),
                };

        "webserver"
          expression => "host001",
          meta => { "inventory", "attribute_name=Role Classes" };

        "webserver"
          expression => regcmp( "^www.*", $(sys.fqhost) ),
          meta => { "inventory", "attribute_name=Role Classes" };
    }

---
## Example - Classify geographic location by network
    !cf3
    # examples/00-20-example-classes-geographic_location_by_network
    bundle common classify_geo_location_by_network
    {
      meta:
        "tags" slist => { "autorun" };

      vars:
        "nadc01_subnets"
          slist => { "172.16.25.0/25", "172.17.0.0/16",
                     "192.168.33.2/32",
                   };

        "nadc02_subnets"
          slist => { "172.17.5.0/25", "172.42.0.0/16",
                     "192.168.33.3/32",
                   };

        "sadc01_subnets"
          slist => { "172.19.4.0/23", "192.168.33.4-5" };

        "continent"
          string => ifelse("north_america", "North America",
                           "south_america", "South America",
                           "Unknown"),
          meta => { "inventory", "attribute_name=Continent" };


      classes:
        "north_america"
          or => { "nadc01", "nadc02" };

        "south_america"
          expression => classmatch("^sadc\d+");

        "nadc01"
          expression => iprange( $(nadc01_subnets) );

        "nadc02"
          expression => iprange( $(nadc02_subnets) );

        "sadc01"
          expression => iprange( $(sadc01_subnets) );

      reports:
        "DEBUG|DEBUG_$(this.bundle)"::
          "DEBUG $(this.bundle): Continent = '$(continent)'";
    }
---
## Example - Manage key value entries in a config file
    !cf3
    # examples/00-20-example-key_value_config.cf
    bundle agent manage_ssh
    {
      meta:
        "tags" slist => { "autorun" };

      methods:
        "SSH Config Data"
          usebundle => ssh_config;

        "Manage SSH Config"
          usebundle => ssh_config_manage_kv("ssh_config.data");
    }

    bundle agent ssh_config
    {
      vars:
          "data[PermitRootLogin]" string => "no";
          "data[Protocol]" string => "2";
          "data[Port]" string => "22";

        DEBUG|DEBUG_ssh_config::
          "keys" slist => getindices(data);

      reports:
        DEBUG|DEBUG_ssh_config::
          "DEBUG $(this.bundle): $(keys) = '$(data[$(keys)])'";
    }

    bundle agent ssh_config_manage_kv(data)
    {
      vars:
        "config" string => "/etc/ssh/sshd_config";

      files:
        "$(config)"
          handle => "ssh_config_manage_kv_entries",
          edit_line => set_line_based("$(data)", " ", "\s+", ".*", "\s*#\s*"),
          classes => scoped_classes_generic("bundle", "sshd_config");

      classes:
        sshd_config_repaired::
          "config_valid"
            expression => returnszero("/usr/sbin/sshd -t -f $(config)", noshell),
            comment => "It's important that we don't restart the service with a
                        broken config, or the service will be down.";

      commands:
        sshd_config_repaired.config_valid::
          "$(paths.service)"
            handle => "ssh_config_manage_kv_restart_after_config_change",
            args => "sshd restart",
            comment => "The service must be restarted in order to pick up new
                        configuration settings.";

      reports:
          "DEBUG $(this.bundle): Reparied configuration"
            if => "sshd_config_repaired";

          "DEBUG $(this.bundle): Configuration Valid"
            if => "config_valid";

          "DEBUG $(this.bundle): Restarted sshd after config change"
            depends_on => { "ssh_config_manage_kv_restart_after_config_change" };
    }

---
## Example - Manage key value entries output
    !shell
    [root@hub masterfiles]# cf-agent -KID DEBUG_ssh_config,DEBUG_ssh_config_manage_kv
        info: Installing cfe_internal_non_existing_package...
    R: DEBUG ssh_config: PermitRootLogin = 'no'
    R: DEBUG ssh_config: Protocol = '2'
    R: DEBUG ssh_config: Port = '22'
        info: Edit file '/etc/ssh/sshd_config'
    R: DEBUG ssh_config_manage_kv: Reparied configuration
        info: Executing 'no timeout' ... '/sbin/service sshd restart'
      notice: Q: "...in/service sshd": Stopping sshd:          [  OK  ]
    Q: "...in/service sshd": Starting sshd:                    [  OK  ]
        info: Last 2 quoted lines were generated by promiser '/sbin/service sshd restart'
        info: Completed execution of '/sbin/service sshd restart'
    R: DEBUG ssh_config_manage_kv: Configuration Valid
    R: DEBUG ssh_config_manage_kv: Restarted sshd after config change

---
## Example - Templating a file
    !cf3
    # examples/00-20-example-mustache_template_vars.cf
    bundle agent motd
    {
      meta:
        "tags" slist => { "autorun" };

      vars:
        "owner" string => "Bruce Wayne";

      files:
        "/etc/motd"
          template_method => "mustache",
          edit_template => "$(this.promise_filename).mustache";
    }

---
## Example - mustache template
    !text
    # examples/00-20-example-mustache_template_vars.cf.mustache
    Welcome to {{{vars.sys.fqhost}}}!

    For support issues please contact {{{vars.motd.owner}}}.

---
## Exercise - Edit a file
Write a policy that populates /etc/issue with legaleze.

---
## Example - Enable sshd banner
Write a policy that enables the ssh banner and directs it to
/etc/issue. sshd should be restarted after changing its configuration.

---
## Example - multiple outcomes

    !cf3
    # Before running this example you should create /tmp/immutable and mark it
    # immutable by running `touch /tmp/immutable; chattr +i /tmp/immutable`. When
    # done cleanup with `chattr -i /tmp/immutable; rm /tmp/immutable`
    bundle agent main
    {
      files:
        "/tmp/immutable"
          create => "true",
          edit_line =>  example_edit_line,
          classes => scoped_classes_generic("bundle", "my_id");

      vars:
        "classes" slist => classesmatching(".*my_id.*");

      reports:
        "Found Class = '$(classes)'";
    }

    bundle edit_line example_edit_line
    {
      insert_lines:
        "I want to edit an immutable file";
    }

    # From the stdlib

    body classes scoped_classes_generic(scope, x)
    # @brief Define `x` prefixed/suffixed with promise outcome
    # **See also:** `scope`
    #
    # @param scope The scope in which the class should be defined
    # @param x The unique part of the classes to be defined
    {
          scope => "$(scope)";
          promise_repaired => { "promise_repaired_$(x)", "$(x)_repaired", "$(x)_ok", "$(x)_reached" };
          repair_failed => { "repair_failed_$(x)", "$(x)_failed", "$(x)_not_ok", "$(x)_error", "$(x)_not_kept", "$(x)_not_repaired", "$(x)_reached" };
          repair_denied => { "repair_denied_$(x)", "$(x)_denied", "$(x)_not_ok", "$(x)_error", "$(x)_not_kept", "$(x)_not_repaired", "$(x)_reached" };
          repair_timeout => { "repair_timeout_$(x)", "$(x)_timeout", "$(x)_not_ok", "$(x)_error", "$(x)_not_kept", "$(x)_not_repaired", "$(x)_reached" };
          promise_kept => { "promise_kept_$(x)", "$(x)_kept", "$(x)_ok", "$(x)_not_repaired", "$(x)_reached" };
    }


---
## Example - multiple outcomes output

    !shell
    > $ cf-agent -KIf ./examples/00-20-example-multiple_outcomes.cf
       error: Can't rename '/tmp/immutable.cf-after-edit' to '/tmp/immutable' - so promised edits could not be moved into place. (rename: Operation not permitted)
       error: Unable to save file '/tmp/immutable' after editing
    R: Found Class = 'my_id_kept'
    R: Found Class = 'my_id_reached'
    R: Found Class = 'repair_failed_my_id'
    R: Found Class = 'my_id_not_repaired'
    R: Found Class = 'promise_kept_my_id'
    R: Found Class = 'my_id_error'
    R: Found Class = 'my_id_failed'
    R: Found Class = 'my_id_not_kept'
    R: Found Class = 'my_id_ok'
    R: Found Class = 'my_id_not_ok'

---
## Exercise - Report
Write a policy that defines a name in separate parts (at least 3). Then have
CFEngine report the name in a random order.

## presenter notes
This solution will print the name multiple times, exposing normal order.

    !cf3
    bundle agent main
    {
      vars:
        "name_parts" slist => { "Ronald", "Mck", "Donald" };
        "shuffled" slist => shuffle( name_parts, randomint(0, inf) );
        "name" string => join(" ", shuffled );

      reports:
        "$(name)";
    }

---
### Example - Restart httpd if it sees its config has changed.
Manually edit the file, then let cfengine restart it based on identification of
the change.

---
## Exercise - Automatically abort based on file presence
Write a policy that will abort cfengine execution if the file
`$(sys.statedir)/abort_agent_execution` exists.

* See abortclasses in the cfengine documentation

---
## Exercise - Delete file based on age
Write a policy that will delete `$(sys.statedir)/abort_agent_execution` if it
is older than 1 hour.

---
## Exercise - Kill a process
Write a policy to kill irssi running on webservers. No need for our webservers
to be connected to IRC.

    !shell
    cp /bin/sleep /tmp/irssi
    /tmp/irssi 5000

---
# Useful Tools and Tips

.fx: titleslide

---
## cf-locate
cf-locate is a command line tool that can help you locate a body or bundle
within a policy set as well as quickly inspect the details for found bodies and
bundles.

## presenter notes

Ever read a policy and see a body that you want to understand more?

Try it with `cf-locate scoped_classes_generic -f /path_to_masterfiles`

---
## Debug Reports

Use standardized DEBUG reports for policy development and troubleshooting.

* DEBUG|DEBUG_this_bundle_name::
    * "DEBUG $(this.bundle): ....";
* "DEBUG|DEBUG_$(this.bundle)"::
    * "DEBUG $(this.bundle): ....";

---
## Promise comments

Use promise comments to document **WHY** the promise is important.

---
## Getting the most from the documentation
