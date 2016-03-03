# CFEngine Language

.fx: titleslide

---
## Promise Theory
* Promise Theory is a model of **voluntary cooperation** between individual
  autonomous actors
* **Promise Theory** is the fundamental underlying philosophy that CFEngine is
  based on.


<a href=http://www.amazon.com/Promise-Theory-Principles-Applications-Volume/dp/1495437779><img src="../images/promise_theory_cover.jpg" alt="Promise Theory Principals and Applications, by Jan A Bergstra & Mark Burgess" height=200px>
</a>

---
## Promises
* A promise is a **statement of intent**
    * The webserver process promises to be running
    * The file promises to have specific permissions

<a href=http://www.amazon.com/gp/product/1491917873><img src="../images/thinking_in_promises_book_cover.jpg" alt="Thinking in Promises Designing Systems for Cooperation, by Mark Burgess" height=200px></a>


---
## Promise outcomes/results
* kept
* repaired
* not_kept
    * failed
    * denied
    * timeout

**Note:** Compound promises **can** have **multiple outcomes** at the same time.

---
## Promise types
There are many type of promises. The promise type available depend on the type of bundle used.

<table>
  <tr>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-classes.html">commands</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-files.html">files</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-services.html">services</a></td>
  </tr>
  <tr>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-packages.html">packages</td></a>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-methods.html">methods</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-defaults.html">defaults</a></td>
  </tr>
  <tr>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-meta.html">meta</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-classes.html">classes</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-reports.html">reports</a></td>
  </tr>
  <tr>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-vars.html">vars</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-databases.html">databases</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-guest_environments.html">guest_environments</a></td>
  </tr>
  <tr>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-processes.html">processes</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-storage.html">storage</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-users.html">users</a></td>
  </tr>
  <tr>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-access.html">access</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-roles.html">roles</a></td>
    <td><a href="https://docs.cfengine.com/latest/reference-promise-types-measurements.html">measurements</a></td>
  </tr>
</table>

---
## Anatomy of a promise

    !cf3
    bundle type name
    {
      promise_type:

        context::

          "promiser" -> { "optional", "stakeholder" }
            attribute_1 => value_1,
            attribute_2 => value_2,
            attribute_3 => value_3,
            attribute_n => value_n;
    }

## presenter notes

* Promise type: What kind? For example packages, or commands
* Context: When/Where? For example prod Linux hosts in north America on Sundays at GMT 1700
* Promiser: What. For example the httpd package, or the name of a command.
* Stakeholders: Who Cards. For example Security Department, a specific policy or compliance id CIS-1.1.17, another promise, a ticketing system identifier.
* Attributes: How/Details. For example should the package be present or absent on the system? Should the command be executed inside of a shell, jailed withing a specific directory, or run as a specific user?
* Why: Why is this important? What can go wrong if this is not in place. Visible in verbose logs.

---
## Bundles
A [**bundle**](https://docs.cfengine.com/latest/guide-language-concepts-bundles.html)
is a collection of promises. It is a logical grouping of any number of
promises, usually for a common purpose. Bundles can optionally
take parameters. Check out the documentation on [best practices with bundles](https://docs.cfengine.com/latest/guide-writing-and-serving-policy-bundles-best-practices.html).

## presenter notes
* Bundles can be used **like** functions
* But bundles are **not** functions
    * Bundles maintain the state their last convergence

---
## Bundles for logical abstraction
For example, a bundle to configure Apache might:

* install the apache2 package
* edit the configuration file
* copy the web server content
* configure file-system permissions
* ensure the httpd process is running
* restart the httpd process when necessary

---
## Bundle types
Bundles have a type which specify how they can be used.

* [common](https://docs.cfengine.com/latest/guide-language-concepts-bundles.html#common-bundles) – evaluated by all components
* [agent](https://docs.cfengine.com/latest/guide-language-concepts-normal-ordering.html#agent-normal-ordering) – evaluated by cf-agent
* [edit_line](https://docs.cfengine.com/latest/reference-promise-types-edit_line.html) - evaluated by cf-agent for files type promises
* [server](https://docs.cfengine.com/latest/guide-language-concepts-normal-ordering.html#server-normal-ordering) – evaluated by cf-serverd
* [monitor](https://docs.cfengine.com/latest/guide-language-concepts-normal-ordering.html#server-normal-ordering) – evaluated by cf-monitord

---
## Normal Order
CFEngine follows [Normal Ordering](https://docs.cfengine.com/latest/guide-language-concepts-normal-ordering.html) when evaluating bundles.

* Classes then Vars are evaluated during [policy parsing](https://docs.cfengine.com/docs/3.7/guide-language-concepts-normal-ordering.html#cf-promises-policy-validation-step) and [pre-eval](https://docs.cfengine.com/docs/3.7/guide-language-concepts-normal-ordering.html#agent-pre-evaluation-step).
* Promises are evaluated from top to bottom respecting class restrictions
* Bundles listed in the bundlesequence or activated via methods are given 3 pass evaluation.

---
## Bodies
A [**body**](https://docs.cfengine.com/latest/guide-language-concepts-bodies.html) is a collection of attributes. Like bundles, bodies can optionally take parameters.

Bodies also like bundles, have a type are used to control agent component behavior as well as specify complex attribute settings for individual promises.

There are [**MANY**](https://docs.cfengine.com/latest/reference-all-types.html#all-body-types) body types.

---
## Pop Quiz
* What is a bundle?
* What is the fundamental underlying philosophy that CFEngine is based on?
* When is the next break?
* Which component collects reports from remote agents?
* What types of bundles are there?
