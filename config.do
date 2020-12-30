* **********************************************************************
* Project:          Project
* Created:
* Last modified:
* Stata v.16.1

* Note: root folder set in Section 0
*       edit $user    in line 28
*       edit $myDocs  in line 30  
*
* **********************************************************************
* does
    /*  Defines path names and sets some key preferences
        Installs dependencies (user-written Stata programs)
        in a local directory
    */

* dependencies
	* add required packages/commands
    local ssc_install   "blindschemes.sthlp estout reghdfe ftools"
    local userpack      "StataConfig"

* TO DO:
    *

* **********************************************************************
* 0 - Define root folder globals
* **********************************************************************
    if "$user" == "et" {
        global myDocs "C:/Users/`c(username)'/Desktop/git"
		if "`c(username)'"=="btje4229" {
			global dropbox ///
			"C:/Users/`c(username)'/Dropbox (Personal)"
		}
		else{
			global dropbox "C:/Users/Emilia/Dropbox"
		}
    }
    if "$user" == "yourName" {
        global myDocs  "~/Dropbox"
    }

* **********************************************************************
* 1 - Sub-directory globals
* **********************************************************************
* Create some sub-folder globals
    global projectFolder          "$myDocs/ProjectName"
    global dataWork               "${projectFolder}/dataWork"
    global data                   "${dataWork}/data"
    global scripts                "${dataWork}/scripts"
    global logs                   "${scripts}/logs"

* **********************************************************************
* 2 - Change ado directory so packages get installed in
*     a project-specific directory
* **********************************************************************
* Create ado folder if it doesn't exist
    qui: capture mkdir      "${scripts}/ado"

* Storing packages here ensures that the project is replicable
* without requiring an internet connection
    sysdir set PERSONAL     "${scripts}/ado/personal"
    sysdir set PLUS         "${scripts}/ado/plus"

* **********************************************************************
* 3 - Set preferences
* **********************************************************************
* Set varabbrev off
    set varabbrev       off
    set more            off
    set logtype         text    // so logs can be opened without Stata

* **********************************************************************
* 4 - Start log file
* **********************************************************************
* String with current date
    local c_date    = c(current_date)
    local cdate     = subinstr("`c_date'", " ", "_", .)

* Start log file
    * generate log folder if it doesn't exist
    qui: capture mkdir  "${logs}"
    cap log             close
    log using           "${logs}/logfile`cdate'.log", replace text


* Note which flavor of Stata
    local variant = cond(c(MP),"MP",cond(c(SE),"SE",c(flavor)) )

* Include in log file info on how and when program was run
    di "=== SYSTEM DIAGNOSTICS ==="
    di "Stata version: `c(stata_version)'"
    di "Updated as of: `c(born_date)'"
    di "Variant:       `variant'"
    di "Processors:    `c(processors)'"
    di "OS:            `c(os)' `c(osdtl)'"
    di "Machine type:  `c(machine_type)'"
    di "=========================="
