r = {"562482"=>[["mir", "Mix"], ["Tor"]], "4824"=>[["fort", "Torf"]], "107835"=>[["je"], ["Bo"], ["da"]]}


t = [["mir", "Mix"], ["Tor", "troll"], ['kalle', 'bongo', 'hugo']]
                                                      
# mir tor kalle
# mir tor bongo
# mir tor hugo   
# mir troll kalle
# mir troll bongo
# mir troll hugo
# mix tor kalle
# mix tor bongo
# mix tor hugo  
# mix troll kalle
# mix troll bongo
# mix troll hugo 



puts cartprod(*t).inspect





