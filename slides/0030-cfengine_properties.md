## CFEngine Properties: Small

* Small

# presenter notes

As of Feb 2014

* < 120K lines of code
* ~ 5MB package
* ~ 15MB Memory Usage

---
## CFEngine Properties: Secure

* Small
* Secure ( [http://web.nvd.nist.gov/view/vuln/search](http://web.nvd.nist.gov/view/vuln/search) )

# presenter notes

* 2005 last published vulnerability (CFEngine 2)
* 0 published vulnerabilities since 2008 when CFEngine 3 was released

---
## CFEngine Properties: Portable

* Small
* Secure ( [http://web.nvd.nist.gov/view/vuln/search](http://web.nvd.nist.gov/view/vuln/search) )
* Portable

# presenter notes

Known to run on many platforms

* HPUX
* Android
* Solaris (sparc/x86)
* Linux
* AIX
* Windows
* Smart infrastructure (interactive bus signs in France)
    * Interactive Bus Signs in France
    * Automated payment system collections
* Lasers (that make puppets)
    * From Hallway track at LISA 2013
* Dialysis Machines (over 50% of machines in the US)
    * From user report
* Appliances
    * Ezuce sipXecs
        * Voip
        * [CFEngine Inside](https://sipfoundry.atlassian.net/wiki/display/sipXecs/cfengine+tips)
    * [Cryptoo](https://github.com/Cryptoo/cfengine)
        * DMZ
        * Tor
        * Bitcoin
        * Bittorrent

---
## CFEngine Properties: Resilient

* Small
* Secure ( [http://web.nvd.nist.gov/view/vuln/search](http://web.nvd.nist.gov/view/vuln/search) )
* Portable
* Resilient

# presenter notes

Works when other things don't, self repair.

* Contained under /var/cfengine (historically should be gaurenteed to be a local fs)
* Policy is cached on the client
* Decisions made locally, designed to not require external resources to make decisisons
* Convergence - Repair what you can

---
## Resilliance
<img src="../images/flesh_wound.jpg">

---
## CFEngine Properties: Declarative

* Small
* Secure ( [http://web.nvd.nist.gov/view/vuln/search](http://web.nvd.nist.gov/view/vuln/search) )
* Portable
* Resilient
* Declarative

# presenter notes
http://blog.aggregatedintelligence.com/2009/06/difference-between-imperative-and.html
http://channel9.msdn.com/blogs/pdc2008/tl16

* Focus on the GOAL
* Align with business priorities

It works kind of like a GPS. It doesn't matter where you start, or the wrong
turns you make it will continually re-route to reach the destination. And your
still responsible for driving, the GPS doesn't drive your car (would you trust
it to? (Alaskan airports, ponds, fields, etc ...)

TODO: Add startrek picture with Make it So?

---
## Declarative vs Imperative
<a href="http://blog.aggregatedintelligence.com/2009/06/difference-between-imperative-and.html"><img src="../images/declarative_vs_imperative_crop.png"/></a>

.notes: <a href="http://blog.aggregatedintelligence.com/2009/06/difference-between-imperative-and.html">Image Source</a> | <a href="https://channel9.msdn.com/blogs/pdc2008/tl16">Original Presentation</a>

---
## Imperative aspects
* Focus on strict order
    * Do this
    * Do that
* Follow a strict process

---
## Declarative aspects
* Focus on end state
    * What should it look like
    * Under what conditions
* Continually converge toward goal

## presenter notes
* Can improve communication with other business units


