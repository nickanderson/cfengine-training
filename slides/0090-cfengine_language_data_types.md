# Data Types

.fx: titleslide

---
## Variable Scoping
* All variables are bundle-local
  * $(variable)
  * Use fully qualified variable names when accessing in other bundles
    * $(bundle.variable)
    * $(namespace:bundle.variable)


---
## Example - strings
    !cf3
    # examples/00-01-strings.cf
    bundle agent main
    {
      vars:
       "string1" string => "one";
        "string2" string => "strings
    can be multi-line";
        "string3" string => "with \"quotes\"";
        "string4" string => 'or "quotes"';
    
      reports:
        "string1 = '$(string1)'";
        "string2 = '$(string2)'";
        "string3 = '$(string3)'";
        "string4 = '$(string4)'";
    }

---
## Example - strings output
    !shell
    $ cf-agent -Kf ./examples/00-01-strings.cf
    R: string1 = 'one'
    R: string2 = 'strings
    can be multi-line'
    R: string3 = 'with "quotes"'
    R: string4 = 'or "quotes"'

---
## Example - numbers
    !cf3
    # examples/00-02-numbers.cf
    bundle agent main
    {
      vars:
        "var1" int => "1";
        "var2" int => "10K";
        "var3" real => "1.2";
        "var4" real => "10e-5";
    
      reports:
        "var1 = '$(var1)'";
        "var2 = '$(var2)'";
        "var3 = '$(var3)'";
        "var4 = '$(var4)'";
    }

## presenter notes
Integer constants may use suffixes to represent large numbers.  The following
suffixes can be used to create integer values for common powers of 1000.

* 'k' = value times 1000
* 'm' = value times 1000^2
* 'g' = value times 1000^3

Since computing systems such as storage and memory are based on binary values,
CFEngine also provide the following uppercase suffixes to create integer
values for common powers of 1024.

* 'K' = value times 1024.
* 'M' = value times 1024^2
* 'G' = value times 1024^3

However, the values must have an integer numeric part (e.g. 1.5M is not
allowed).

In some contexts, `%` can be used a special suffix to denote percentages.

Lastly, there is a reserved value which can be used to specific a parameter as
having no limit at all.

* 'inf' = a constant representing an unlimited value.

---
## Example - numbers output
    !shell
    $ cf-agent -Kf ./examples/00-02-numbers.cf
    R: var1 = '1'
    R: var2 = '10240'
    R: var3 = '1.200000'
    R: var4 = '0.000100'

---
## Example - list iteration
    !cf3
    # examples/00-03-list_iteration.cf
    bundle agent main
    {
      vars:
        "numbers" slist => { "1", "2", "3" };
        "colors" slist => { "red", "green", "blue" };
    
      reports:
        "$(numbers)";
        "$(colors)";
        "$(numbers) with $(colors)";
        "$(colors) with $(numbers)";
    }



---
## Example - list iteration output
    !shell
    $ cf-agent -Kf ./examples/00-03-list_iteration.cf
    R: 1
    R: 2
    R: 3
    R: red
    R: green
    R: blue
    R: 1 with red
    R: 2 with red
    R: 3 with red
    R: 1 with green
    R: 2 with green
    R: 3 with green
    R: 1 with blue
    R: 2 with blue
    R: 3 with blue
    R: red with 1
    R: green with 1
    R: blue with 1
    R: red with 2
    R: green with 2
    R: blue with 2
    R: red with 3
    R: green with 3
    R: blue with 3

---
## Example - lists
    !cf3
    # examples/00-04-lists.cf
    bundle agent main
    {
      vars:
        "var1" ilist => { 1, 2, "3", "4" };
        "var2" rlist => { "1.2", "2.0", "3.3" };
        "var3" slist => { "one", "two", three,
                          @(var1), @(var2),
                        };
        "var4" real => sum( var2 );

      reports:
        "var1 = '$(var1)'";
        "var2 = '$(var2)'";
        "var3 = '$(var3)'";
        "var4 = '$(var4)'";
    }

---
## Example - lists output
    !shell
    $ cf-agent -Kf ./examples/00-04-lists.cf
    R: var1 = '1'
    R: var1 = '2'
    R: var1 = '3'
    R: var1 = '4'
    R: var2 = '1.2'
    R: var2 = '2.0'
    R: var2 = '3.3'
    R: var3 = 'one'
    R: var3 = 'two'
    R: var3 = 'three'
    R: var3 = '1'
    R: var3 = '2'
    R: var3 = '3'
    R: var3 = '4'
    R: var3 = '1.2'
    R: var3 = '2.0'
    R: var3 = '3.3'
    R: var4 = '6.500000'

---
## Example - "Classic" Arrays
    !cf3
    # examples/00-05-classic_arrays.cf
    bundle agent main
    {
      vars:
        "file[motd]"  string => "/etc/motd";
        "file[fstab]" string => "/etc/fstab";

        "file_idx" slist => getindices( file );
        "files" slist => getvalues( file );

      reports:
       "The key '$(file_idx)' has the value '$(file[$(file_idx)])'";
       "file: '$(files)'";
    }

---
## Example - "Classic" Arrays output
    !shell
    $ cf-agent -Kf ./examples/00-05-classic_arrays.cf
    R: The key 'motd' has the value '/etc/motd'
    R: The key 'fstab' has the value '/etc/fstab'
    R: file: '/etc/motd'
    R: file: '/etc/fstab'

---
## Example - data containers
    !cf3
    # examples/00-06-data_containers.cf
    bundle agent main
    {
      vars:
        "server" string => "mirror.int.cfengine.com";
        "repos"
          data => parsejson('{
                    "rhel6_updates": {
                      "id": { "value":"RHEL6_UPDATES" },
                      "name": { "value": "RHEL 6.x Updates" },
                      "baseurl": { "value": "https://$(server)/RHEL6/updates" }
                    }
                  }');

        "idx" slist => getindices( repos );

      reports:
        "URL = '$(repos[$(idx)][baseurl][value])'";
    }

---
## Example - data containers output
    !shell
    $ cf-agent -Kf ./examples/00-06-data_containers.cf
    R: URL = 'https://mirror.int.cfengine.com/RHEL6/updates'

---
## Pop Quiz
- Which component makes changes to your system?
- Which component schedules agent runs?
- What symbol terminates a promise?
- What is your quest?
- What are promise comments used for?
- What types of variables are available?
- How are decisions made?
