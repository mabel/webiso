BASE_URL = 'http://192.168.0.167:7529/cgi-bin/mountiso.sh'
childProc = require 'child_process'
$ = require 'jquery'

umount = ->
    new Promise (yep, nop)->
        umnt = childProc.spawn '/usr/bin/sudo', ['/bin/umount', '/mnt/remoteiso']
        umnt.on 'close', yep
mount = ->
    new Promise (yep, nop)->
        mnt = childProc.spawn '/usr/bin/sudo', ['/bin/mount', '/mnt/remoteiso']
        mnt.on 'close', yep

thunar = ->
    return unless confirm 'Открыть в проводнике?'
    new Promise (yep, nop)->
        mnt = childProc.spawn '/usr/bin/thunar', ['/mnt/remoteiso']
        mnt.on 'close', yep

$ ->
    $('ul li a').click (e)->
        e.preventDefault()
        href = $(@).attr 'href'
        $.get "#{BASE_URL}?#{href}", ->
            umount()
                .then mount
                .then thunar
                .catch (err)-> console.log err
        false
