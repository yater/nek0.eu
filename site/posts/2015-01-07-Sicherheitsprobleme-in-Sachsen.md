---
title: Sicherheitsprobleme in Sachsen
author: nek0
tags: deutsch, crypto, misc
description: 
---

Ich betreibe ja schon seit einiger Zeit mit Freunden einen Server, auf welchem ich mich vornehmlich für die Email-Infrastruktur verantwortlich fühle.

Neulich wurde ich auf ein Problem aufmerksam gemacht, dass der Emailverkehr mit den Hochschulen zum Erliegen gekommen ist. Zuerst vermutete ich einen Fehler in unserer Konfiguration, doch die Wahrheit war schlimmer. Die Hochschulen und Universitäten können kein TLS.

Warum dieser Fehler erst jetzt aufgekommen ist, ist schnell erklärt. Aus Kompatibilitätsgründen hatten wir Unterstützung für SSLv3 aktiv gehabt. Kurz nach dem bekannt werden der [Poodle Attacke][Poodle], welche auch die letzten Stückchen Sicherheit im SSL-Protokol aushebelt, habe ich bei unserem Server die Unterstützung für das Protokoll abgeschaltet, in dem Vertrauen, dass andere Betreiber von Mailservern zeitgemäße Sicherheitsstandards bei sich durchsetzen.

Leider werde ich im Moment von den Einrichtungen, welche eigentlich für Innovation und technologische Vorreiter stehen enttäuscht. Nicht nur dass diese immer noch das veraltete SSL-Protokoll unterstützen. Sie unterstützen gar kein TLS im Mailverkehr. Überhaupt nicht. Auch die hochgelobte Exzellenz-Universität in Dresden nicht.

Es kann doch nicht sein, dass die Rechenzentren an Hochschulen keine zeitgemäße Sicherheit anbieten. Nicht nur das, sie arbeiten technisch wörtlich auf dem Stand des letzten Jahrtausends, denn immerhin stammt TLS aus dem Jahre 1999. Es ist also zwischendurch genug Zeit gewesen die Konfigurationen anzupassen.

&lt;/rant&gt;

[Poodle]: http://de.wikipedia.org/wiki/Poodle
