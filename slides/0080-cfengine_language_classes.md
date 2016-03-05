# Making Decisions: Context Classes and Expressions

.fx: titleslide

---
## Classes

[Classes](https://docs.cfengine.com/latest/guide-language-concepts-classes.html) are used to restrict promises only to a particular [set](https://en.wikipedia.org/wiki/Set_%28mathematics%29) of nodes depending 
on context. A promise might only apply to Linux systems on Sundays, when a 
[variable](https://docs.cfengine.com/latest/guide-language-concepts-variables.html) has a certain value or any other arbitrary condition or
combination of various conditions.

* Either defined or undefined (undefined could mean undefined *yet*)
* Usable in bundles and bodies
* Used for making decisions by combining into complex expressions

---
## Show Classes
    !console
    $ cf-promises --show-classes
    Class name                                                   Meta tags                               
    127_0_0_1                                                    inventory,attribute_name=none,source=agent,hardclass
    4_cpus                                                       source=agent,derived-from=sys.cpus,hardclass
    64_bit                                                       source=agent,hardclass                  
    Afternoon                                                    time_based,source=agent,hardclass       
    Day27                                                        time_based,source=agent,hardclass       
    GMT_Afternoon                                                time_based,source=agent,hardclass       
    GMT_Day27                                                    time_based,source=agent,hardclass       
    GMT_Hr17                                                     time_based,source=agent,hardclass       
    GMT_Hr17_Q2                                                  time_based,source=agent,hardclass       
    GMT_Lcycle_2                                                 time_based,source=agent,hardclass       
    GMT_Min25_30                                                 time_based,source=agent,hardclass       
    GMT_Min26                                                    time_based,source=agent,hardclass       
    GMT_Q2                                                       time_based,source=agent,hardclass       
    GMT_September                                                time_based,source=agent,hardclass       
    GMT_Sunday                                                   time_based,source=agent,hardclass       
    GMT_Yr2015                                                   time_based,source=agent,hardclass       
    Hr12                                                         time_based,source=agent,hardclass       
    Hr12_Q2                                                      time_based,source=agent,hardclass       
    Lcycle_2                                                     time_based,source=agent,hardclass       
    Min25_30                                                     time_based,source=agent,hardclass       
    Min26                                                        time_based,source=agent,hardclass       
    PK_SHA_31bcb32950d8b91ffdfca85bca71364ec8f67c93246e3617c3a49af58363c4a1 inventory,attribute_name=none,source=agent,derived-from=sys.key_digest,hardclass
    Q2                                                           time_based,source=agent,hardclass       
    September                                                    time_based,source=agent,hardclass       
    Sunday                                                       time_based,source=agent,hardclass       
    Yr2015                                                       time_based,source=agent,hardclass       
    __os_release_id_                                             source=promise                          
    __os_release_id____os_release_version_                       source=promise                          
    __override_classes_                                          source=promise,override                 
    _have_bin_systemctl                                          source=promise                          
    _stdlib_has_path_apt_cache                                   source=promise                          
    _stdlib_has_path_apt_config                                  source=promise                          
    _stdlib_has_path_apt_get                                     source=promise                          
    _stdlib_has_path_apt_key                                     source=promise                          
    _stdlib_has_path_aptitude                                    source=promise                          
    _stdlib_has_path_awk                                         source=promise                          
    _stdlib_has_path_bc                                          source=promise                          
    _stdlib_has_path_cat                                         source=promise                          
    _stdlib_has_path_chkconfig                                   source=promise                          
    _stdlib_has_path_cksum                                       source=promise                          
    _stdlib_has_path_createrepo                                  source=promise                          
    _stdlib_has_path_crontab                                     source=promise                          
    _stdlib_has_path_crontabs                                    source=promise                          
    _stdlib_has_path_curl                                        source=promise                          
    _stdlib_has_path_cut                                         source=promise                          
    _stdlib_has_path_dc                                          source=promise                          
    _stdlib_has_path_df                                          source=promise                          
    _stdlib_has_path_diff                                        source=promise                          
    _stdlib_has_path_dig                                         source=promise                          
    _stdlib_has_path_dmidecode                                   source=promise                          
    _stdlib_has_path_domainname                                  source=promise                          
    _stdlib_has_path_dpkg                                        source=promise                          
    _stdlib_has_path_echo                                        source=promise                          
    _stdlib_has_path_egrep                                       source=promise                          
    _stdlib_has_path_env                                         source=promise                          
    _stdlib_has_path_ethtool                                     source=promise                          
    _stdlib_has_path_find                                        source=promise                          
    _stdlib_has_path_free                                        source=promise                          
    _stdlib_has_path_getfacl                                     source=promise                          
    _stdlib_has_path_git                                         source=promise                          
    _stdlib_has_path_grep                                        source=promise                          
    _stdlib_has_path_groupadd                                    source=promise                          
    _stdlib_has_path_hostname                                    source=promise                          
    _stdlib_has_path_ifconfig                                    source=promise                          
    _stdlib_has_path_init                                        source=promise                          
    _stdlib_has_path_ip                                          source=promise                          
    _stdlib_has_path_iptables                                    source=promise                          
    _stdlib_has_path_iptables_save                               source=promise                          
    _stdlib_has_path_logger                                      source=promise                          
    _stdlib_has_path_ls                                          source=promise                          
    _stdlib_has_path_lsattr                                      source=promise                          
    _stdlib_has_path_lsof                                        source=promise                          
    _stdlib_has_path_netstat                                     source=promise                          
    _stdlib_has_path_nologin                                     source=promise                          
    _stdlib_has_path_npm                                         source=promise                          
    _stdlib_has_path_perl                                        source=promise                          
    _stdlib_has_path_ping                                        source=promise                          
    _stdlib_has_path_pip                                         source=promise                          
    _stdlib_has_path_printf                                      source=promise                          
    _stdlib_has_path_realpath                                    source=promise                          
    _stdlib_has_path_sed                                         source=promise                          
    _stdlib_has_path_service                                     source=promise                          
    _stdlib_has_path_shadow                                      source=promise                          
    _stdlib_has_path_sort                                        source=promise                          
    _stdlib_has_path_svc                                         source=promise                          
    _stdlib_has_path_sysctl                                      source=promise                          
    _stdlib_has_path_systemctl                                   source=promise                          
    _stdlib_has_path_tar                                         source=promise                          
    _stdlib_has_path_test                                        source=promise                          
    _stdlib_has_path_tr                                          source=promise                          
    _stdlib_has_path_update_alternatives                         source=promise                          
    _stdlib_has_path_update_rc_d                                 source=promise                          
    _stdlib_has_path_useradd                                     source=promise                          
    _stdlib_has_path_wc                                          source=promise                          
    _stdlib_has_path_wget                                        source=promise                          
    _stdlib_path_exists_apt_cache                                source=promise                          
    _stdlib_path_exists_apt_config                               source=promise                          
    _stdlib_path_exists_apt_get                                  source=promise                          
    _stdlib_path_exists_apt_key                                  source=promise                          
    _stdlib_path_exists_aptitude                                 source=promise                          
    _stdlib_path_exists_awk                                      source=promise                          
    _stdlib_path_exists_bc                                       source=promise                          
    _stdlib_path_exists_cat                                      source=promise                          
    _stdlib_path_exists_cksum                                    source=promise                          
    _stdlib_path_exists_crontab                                  source=promise                          
    _stdlib_path_exists_crontabs                                 source=promise                          
    _stdlib_path_exists_curl                                     source=promise                          
    _stdlib_path_exists_cut                                      source=promise                          
    _stdlib_path_exists_dc                                       source=promise                          
    _stdlib_path_exists_df                                       source=promise                          
    _stdlib_path_exists_diff                                     source=promise                          
    _stdlib_path_exists_dig                                      source=promise                          
    _stdlib_path_exists_dmidecode                                source=promise                          
    _stdlib_path_exists_domainname                               source=promise                          
    _stdlib_path_exists_dpkg                                     source=promise                          
    _stdlib_path_exists_echo                                     source=promise                          
    _stdlib_path_exists_egrep                                    source=promise                          
    _stdlib_path_exists_env                                      source=promise                          
    _stdlib_path_exists_ethtool                                  source=promise                          
    _stdlib_path_exists_find                                     source=promise                          
    _stdlib_path_exists_free                                     source=promise                          
    _stdlib_path_exists_getfacl                                  source=promise                          
    _stdlib_path_exists_git                                      source=promise                          
    _stdlib_path_exists_grep                                     source=promise                          
    _stdlib_path_exists_groupadd                                 source=promise                          
    _stdlib_path_exists_hostname                                 source=promise                          
    _stdlib_path_exists_ifconfig                                 source=promise                          
    _stdlib_path_exists_init                                     source=promise                          
    _stdlib_path_exists_ip                                       source=promise                          
    _stdlib_path_exists_iptables                                 source=promise                          
    _stdlib_path_exists_iptables_save                            source=promise                          
    _stdlib_path_exists_logger                                   source=promise                          
    _stdlib_path_exists_ls                                       source=promise                          
    _stdlib_path_exists_lsattr                                   source=promise                          
    _stdlib_path_exists_lsof                                     source=promise                          
    _stdlib_path_exists_netstat                                  source=promise                          
    _stdlib_path_exists_nologin                                  source=promise                          
    _stdlib_path_exists_perl                                     source=promise                          
    _stdlib_path_exists_ping                                     source=promise                          
    _stdlib_path_exists_pip                                      source=promise                          
    _stdlib_path_exists_printf                                   source=promise                          
    _stdlib_path_exists_realpath                                 source=promise                          
    _stdlib_path_exists_sed                                      source=promise                          
    _stdlib_path_exists_service                                  source=promise                          
    _stdlib_path_exists_shadow                                   source=promise                          
    _stdlib_path_exists_sort                                     source=promise                          
    _stdlib_path_exists_svc                                      source=promise                          
    _stdlib_path_exists_sysctl                                   source=promise                          
    _stdlib_path_exists_systemctl                                source=promise                          
    _stdlib_path_exists_tar                                      source=promise                          
    _stdlib_path_exists_test                                     source=promise                          
    _stdlib_path_exists_tr                                       source=promise                          
    _stdlib_path_exists_update_alternatives                      source=promise                          
    _stdlib_path_exists_update_rc_d                              source=promise                          
    _stdlib_path_exists_useradd                                  source=promise                          
    _stdlib_path_exists_wc                                       source=promise                          
    _stdlib_path_exists_wget                                     source=promise                          
    any                                                          source=agent,hardclass                  
    cfengine                                                     inventory,attribute_name=none,source=agent,hardclass
    cfengine_3                                                   inventory,attribute_name=none,source=agent,hardclass
    cfengine_3_7                                                 inventory,attribute_name=none,source=agent,hardclass
    cfengine_3_7_1                                               inventory,attribute_name=none,source=agent,hardclass
    cfengine_in_low                                              monitoring,source=environment,hardclass 
    cfengine_internal_agent_email                                source=promise                          
    cfengine_internal_rotate_logs                                source=promise                          
    common                                                       cfe_internal,source=agent,hardclass     
    compiled_on_linux_gnu                                        source=agent,hardclass                  
    cpu0_low                                                     monitoring,source=environment,hardclass 
    cpu1_low                                                     monitoring,source=environment,hardclass 
    cpu2_low_normal                                              monitoring,source=environment,hardclass 
    cpu3_low_normal                                              monitoring,source=environment,hardclass 
    cpu_low_normal                                               monitoring,source=environment,hardclass 
    debian                                                       inventory,attribute_name=none,source=agent,hardclass
    debian_derived                                               source=promise,inventory,attribute_name=none
    debian_jessie                                                inventory,attribute_name=none,source=agent,hardclass
    disable_inventory_LLDP                                       source=promise                          
    disable_inventory_cmdb                                       source=promise                          
    diskfree_high                                                monitoring,source=environment,hardclass 
    enable_cfe_internal_cleanup_agent_reports                    source=promise                          
    enterprise                                                   inventory,attribute_name=none,source=agent,hardclass
    enterprise_3                                                 inventory,attribute_name=none,source=agent,hardclass
    enterprise_3_7                                               inventory,attribute_name=none,source=agent,hardclass
    enterprise_3_7_1                                             inventory,attribute_name=none,source=agent,hardclass
    enterprise_edition                                           inventory,attribute_name=none,source=agent,hardclass
    entropy_cfengine_in_low                                      monitoring,source=environment,hardclass 
    entropy_imaps_out_low                                        monitoring,source=environment,hardclass 
    entropy_misc_in_low                                          monitoring,source=environment,hardclass 
    entropy_misc_out_low                                         monitoring,source=environment,hardclass 
    entropy_postgresql_in_low                                    monitoring,source=environment,hardclass 
    entropy_postgresql_out_low                                   monitoring,source=environment,hardclass 
    entropy_ssh_out_low                                          monitoring,source=environment,hardclass 
    entropy_www_alt_out_low                                      monitoring,source=environment,hardclass 
    feature                                                      source=agent,hardclass                  
    feature_xml                                                  source=agent,hardclass                  
    feature_yaml                                                 source=agent,hardclass                  
    has_lsb_release                                              source=promise                          
    has_os_release                                               source=promise                          
    has_proc_1_cmdline                                           source=promise                          
    have_aptitude                                                inventory,attribute_name=none,source=agent,hardclass
    imaps_out_low                                                monitoring,source=environment,hardclass 
    io_readdata_low                                              monitoring,source=environment,hardclass 
    io_reads_low                                                 monitoring,source=environment,hardclass 
    io_writes_low                                                monitoring,source=environment,hardclass 
    io_writtendata_high                                          monitoring,source=environment,hardclass 
    ipp_in_high                                                  monitoring,source=environment,hardclass 
    ipp_out_high                                                 monitoring,source=environment,hardclass 
    ipv4_127                                                     inventory,attribute_name=none,source=agent,hardclass
    ipv4_127_0                                                   inventory,attribute_name=none,source=agent,hardclass
    ipv4_127_0_0                                                 inventory,attribute_name=none,source=agent,hardclass
    ipv4_127_0_0_1                                               inventory,attribute_name=none,source=agent,hardclass
    linux                                                        inventory,attribute_name=none,source=agent,derived-from=sys.class,hardclass
    linux_3_19_0_25_generic                                      source=agent,derived-from=sys.sysname,derived-from=sys.release,hardclass
    linux_x86_64                                                 source=agent,derived-from=sys.sysname,derived-from=sys.machine,hardclass
    linux_x86_64_3_19_0_25_generic                               source=agent,derived-from=sys.sysname,derived-from=sys.machine,derived-from=sys.release,hardclass
    linux_x86_64_3_19_0_25_generic__26_Ubuntu_SMP_Fri_Jul_24_21_17_31_UTC_2015 source=agent,derived-from=sys.long_arch,hardclass
    loadavg_high_dev1                                            monitoring,source=environment,hardclass 
    mem_freeswap_high_normal                                     monitoring,source=environment,hardclass 
    mem_swap_high_normal                                         monitoring,source=environment,hardclass 
    mem_total_high_normal                                        monitoring,source=environment,hardclass 
    net_iface_lo                                                 source=agent,hardclass                  
    nickanderson_thinkpad_w550s                                  inventory,attribute_name=none,source=agent,derived-from=sys.fqhost,hardclass
    nova                                                         inventory,attribute_name=none,source=agent,hardclass
    nova_3                                                       inventory,attribute_name=none,source=agent,hardclass
    nova_3_7                                                     inventory,attribute_name=none,source=agent,hardclass
    nova_3_7_1                                                   inventory,attribute_name=none,source=agent,hardclass
    nova_edition                                                 source=agent,hardclass                  
    os_release_has_id                                            source=promise                          
    os_release_has_version                                       source=promise                          
    otherprocs_high_normal                                       monitoring,source=environment,hardclass 
    rootprocs_high_dev1                                          monitoring,source=environment,hardclass 
    specific_linux_os                                            source=promise                          
    ssh_in_high                                                  monitoring,source=environment,hardclass 
    ssh_out_low                                                  monitoring,source=environment,hardclass 
    syslog_high_dev1                                             monitoring,source=environment,hardclass 
    systemd                                                      inventory,attribute_name=none,source=agent,hardclass
    temp0_low_anomaly                                            monitoring,source=environment,hardclass,source=persistent
    temp0_low_dev1                                               monitoring,source=environment,hardclass 
    temp0_low_dev2                                               monitoring,source=environment,hardclass,source=persistent
    temp1_low_normal                                             monitoring,source=environment,hardclass 
    ubuntu                                                       inventory,attribute_name=none,source=agent,hardclass
    ubuntu_15                                                    inventory,attribute_name=none,source=agent,derived-from=sys.flavor,hardclass
    ubuntu_15_4                                                  inventory,attribute_name=none,source=agent,hardclass
    users_high                                                   monitoring,source=environment,hardclass 
    www_alt_out_low                                              monitoring,source=environment,hardclass 
    www_out_low                                                  monitoring,source=environment,hardclass 
    wwws_out_high_dev1                                           monitoring,source=environment,hardclass 
    x86_64                                                       source=agent,derived-from=sys.machine,hardclass

## presenter notes
Note, show-classes will not show ALL possible classes. It only performs
pre-eval so it is only showing the classes that are defined after pre-eval.

---
## Class expressions
Classes can be combined into expressions to make complex decisions.

<table>
  <tr><td><strong>.</strong> (dot) = AND <strong>*</strong></td></tr>
  <tr><td><strong>&</strong> (ampersand) = AND</td></tr>
  <tr><td><strong>|</strong> (pipe) = OR</td></tr>
  <tr><td><strong>!</strong> (exclamation) = NOT</td></tr>
  <tr><td><strong>()</strong> (parenthesis) = grouping</td></tr>
</table>

<strong>*</strong> It's more common to use the dot than ampersand to express AND

---
## classes example
    !cf3
    bundle agent main
    {
      files:
        linux.(Sunday|Saturday)::
          "/etc/nologin" -> { "Human Resources" }
            create => "true",
            comment => "Disallow non-root logins on the weekend.
                        We believe in work-life balance, and
                        encourage it.";

        linux.!(Sunday|Saturday)::
          "/etc/nologin" -> { "Business Operations" }
            delete => tidy,
            comment => "People need to be able to log in for them
                      to do their work during the week";
    }

## presenter notes

Here we use class expressions to make sure that unprivileged users are not
allowed to log in on the weekend, and also that they are allowed
to log in during the week.

---
## Class types
There are two types of classes, hard classes and soft classes.

* [Hard classes](https://docs.cfengine.com/latest/guide-language-concepts-classes.html#hard-classes)
* [Soft classes](https://docs.cfengine.com/latest/guide-language-concepts-classes.html#soft-classes)

---
## Hard classes
* Hard classes
    * Defined by agent
    * Not configurable
    * Always available
    * Discovered each run
    * Cannot be undefined

redhat, Thursday, linux

---
## Soft classes
* Soft classes
    * Defined by policy
    * Based on anything
    * Available after definition
    * Can persist for period of time
    * Can be namespace or bundle scoped
    * Can be undefined

webserver, prod_env, north_america

---
## Class naming
Valid class names contain only alphanumeric characters and underscores.
`[a-zA-Z0-9_]`. When **defining** classes, invalid characters are
generally automatically
[canonified](https://docs.cfengine.com/latest/reference-functions-canonify.html)
for convenience.

**Note:** Classes are **NOT** automatically canonified when **tested**.

## presenter notes
* Automatic canonification may or may not result in log entries for various log levels.

---
## Example - class canonification
    !cf3
    # examples/00-01-classes_canonification.cf
    bundle agent main
    {
      vars:
        "my_class_name" string => "Invalid-Class/Name!";
        "c_my_class_name" string => canonify( "$(my_class_name)" );

      classes:
        "$(my_class_name)" expression => "any";

      reports:

        "'$(my_class_name)' is **NOT** a class that is defined"
          unless => "$(my_class_name)";

        "'$(c_my_class_name)' **IS** a defined class"
          if => canonify( $(my_class_name) );
    }

---
## Example - class canonification output
    !shell
    $ cf-agent -Kf ./examples/00-01-classes_canonification.cf
    R: 'Invalid-Class/Name!' is **NOT** a class that is defined
    R: 'Invalid_Class_Name_' **IS** a defined class

---
## Class scope
Classes are either [namespace scoped, or bundle scoped](https://docs.cfengine.com/latest/guide-language-concepts-classes.html#global-and-local-classes).

* Namespace scoped classes are accessible from any bundle.
* Bundle scoped classes are only accessible from within the bundle the class was defined.
* All hard classes are namespace scoped

Namespace scoped classes are also referred to as "global" classes.

Inventoried classes **must** be namespace scoped.

.notes: Don't worry too much about namespaces yet. It's an advanced topic and mostly relates to very large policy sets or environments with many different groups of policy writers.

---
## Class scope rules
* By default classes defined by classes type promises in **common bundles** are **namespace scoped**
* By default classes defined by classes type promises in **agent bundles** are **bundle scoped**
* By default classes defined as the **result of promise outcomes** (`classes bodies`) are **namespace scoped**

**Pro Tip:** Only use namespace scoped classes when necessary

## presenter notes

Namespace scope classes if not maintained well can cause other conditions to be
met unexpectedly. For example, consider if you defined the class
`config_repaired` or `restart_service`. Which config, which service?

---
## Define custom classes by expression
    !cf3
    # examples/00-10-classes_by_expression.cf
    bundle agent main
    {
      classes:
        "weekend" or => { "Saturday", "Sunday" };
        "weekday" not => { "weekend" };

        "business_hours"
          expression => "weekday.(Hr9|Hr10|Hr11|Hr13|Hr14|Hr15|Hr16|Hr17)",
          comment => "Weekdays from 9-5 excluding the lunch hour.";

        "webserver"
          expression => regcmp( "www.*", $(sys.fqhost) ),
          comment => "Identify webservers based on their name";

        "north_america"
          expression => iprange( "10.1.0.0/16" );
    }

---
## Define custom classes by promise outcome
    !cf3
    # examples/00-10-classes_define_based_on_promise_outcome.cf
    bundle agent main
    {
      vars:
        "config[PermitRootLogin]" string => "no";

      files:
        "/etc/ssh/sshd_config"
          edit_line => set_line_based("$(this.bundle).config", " ", "\s+", ".*", "\s*#\s*"),
          classes => scoped_classes_generic("bundle", "sshd_config");

      services:
        sshd_config_repaired::
          "sshd"
            service_policy => "restart",
            comment => "For sshd to pick up changed config it must be restarted."
    }

---
## Example - traditional class expressions
    !cf3
    # examples/00-10-classes_traditional_expression.cf
    bundle agent main
    {
      reports:
        linux.!(Saturday|Sunday)::
          "This is a linux host";
          "Today is not Saturday or Sunday";
    }

Traditional class expressions apply until the next class expression, promise
type, or end of bundle.If unspecified promises are in the `any` context.

## presenter notes

Variables are not allowed in traditional class expressions.

---
## Example - ifvarclass
    !cf3
    # examples/00-10-classes_example_ifvarclass.cf
    bundle agent main
    {
      vars:
        "platforms" slist => { "linux", "windows" };

      reports:
        "I am a $(platforms) host"
          ifvarclass => "$(platforms)";
    }

[ifvarclass](https://docs.cfengine.com/latest/reference-promise-types.html#ifvarclass)
is useful when you want to restrict an **individual** promise based on a class
matching the content of a variable.

## presenter notes
It's also useful to further restrict a promise in combination with a
traditional class expression as it acts as an **AND** with a traditional class
expression.

---
## Example - if and unless
Better readability with if/unless

    !cf3
    # examples/00-10-classes_example_if_and_unless.cf
    bundle agent main
    {
      vars:
        "platforms" slist => { "linux", "windows" };

      reports:
        "I am a $(platforms) host"
          if => "$(platforms)";

        "I was made by Microsoft"
          unless => "!windows";
    }

if and unless are shorter to type and easier to read.

## presenter notes

In 3.7 if was added as an alias to ifvarclass and its negative unless was added
as an alias for negating ifvarclass with not. They are now the preferred
attribute for readability.

---
## Example - variable class expressions
More flexibility with variable class expressions

    !cf3
    # examples/00-10-classes_example_variable_class_expressions.cf
    bundle agent main
    {
      vars:
        "platforms" slist => { "linux", "windows" };

      reports:
        "$(platforms)"::
          "I am a $(platforms) host";
    }

Like traditional class expressions variable class expressions apply until the
next class expression, promise type, or end of bundle.

## presenter notes

In 3.7 traditional class expressions gained the ability to de-reference
variables when quoted.

---
## Pop Quiz
* What types of classes are there?
    * What is the difference?
* What are valid class characters?
