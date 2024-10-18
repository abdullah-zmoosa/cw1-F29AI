;
; A simplified version of the logistics domain with
; conditional and quantified effects
;
(define (domain underwater_search)
    (:requirements
        :strips
    )

    (:predicates
        (commandcenter ?cmc)
        (personnel ?prsnl)
        (subs ?subs)
        (land ?l)
        (engineers ?eng)
        (scientists ?sci)
        (pilots ?pilt)
        (shallowwater ?shw)
        (deepwater ?dpw)
        (currentlocation ?cloc)
        (adjacentlocation ?al1 ?al2)
        (seated ?subs ?seat1 ?seat2)
        (onboard ?prsnl ?subs)
        (constructionKit ?kit)
        (structureKit ?kit)
        (cableKit ?kit)
        (kitbox ?sub ?slot)
        (inkitbox ?sub ?slot ?kit)
        (emptykitbox ?sub ?slot)
        (structurekit ?skit)
        (energykit ?ekit)
        (safeconstruction ?sc)
        (gathereddata ?gad)
        
        
    )

    (:action sub_move
        :parameters 
            (?loc1 ?loc2 ?subs)
        :precondition
            (and
            ((or(shallowwater ?loc1) (deepwater ?loc1)))
            ((or(shallowwater ?loc2) (deepwater ?loc2)))
            (pilots ?subs)
            (currentlocation ?s ?loc1)
            (adjacentlocation ?loc1 ?loc2)
            )
        :effect
            (and
            (not (currentlocation ?subs ?loc1))
            (currentlocation ?subs ?loc2)
            )
    )
    (:action adjacent
        :parameters 
            (?loc1 ?loc2)
        :precondition 
            (adjacent ?loc1 ?loc2)
        :effect (and
            (adjacent ?loc2 ?loc1)
    )
)
    
    
     (:action board_seat1
        :parameters 
            (?subs ?seat1 ?seat2 ?prsnl ?loc )
        :precondition 
            (currentlocation ?subs ?loc)
            (currentlocation ?prsnl ?loc)
            (seated ?subs ?seat1 ?seat2)
            (emptyseat ?subs ?seat1)
            
        :effect (and
            (not(currentlocation ?prsnl ?loc)
            (not(emptyseat ?subs ?seat1))
            (on board ?prsnl ?subs)
            
            
    )
)
)

    (:action board_seat2
        :parameters 
            (?subs ?seat2 ?prsnl ?loc)
        :precondition 
            (currentlocation ?subs ?loc)
            (currentlocation ?prsnl ?loc)
            (seated ?subs ?seat1 ?seat2)
            (emptyseat ?subs ?seat2)
            
        :effect (and
            (not(currentlocation ?prsnl ?loc))
            (not(emptyseat ?subs ?seat2))
            (onboard ?prsnl ?subs)
            
            
    )
)


    (:action unboard_seat1
        :parameters 
            (?subs ?seat1 ?seat2 ?prsnl ?loc)
        :precondition 
            (onboard ?prsnl ?subs)
            (currentlocation ?subs ?loc)
            (seated ?subs ?seat1 ?seat2)
            (not(emptyseat ?subs ?seat1))
            
        :effect (and
            (currentlocation ?prsnl ?loc)
            (emptyseat ?subs ?seat1)
            (not(on board ?prsnl ?subs))
            
            
    )
)
    (:action unboard_seat2
        :parameters 
            (?subs ?seat2 ?prsnl ?loc)
        :precondition 
            (onboard ?prsnl ?subs)
            (currentlocation ?subs ?loc)
            (seated ?subs ?seat1 ?seat2)
            (not(emptyseat ?subs ?seat2))
        :effect (and
            (currentlocation ?prsnl ?loc)
            (emptyseat ?subs ?seat2)
            (not(on board ?prsnl ?subs))
            
            
    )
)
 
 
 (:action submarinekitload
        :parameters(?subs ?kit ?eng ?slot ?loc)
        :precondition(and 
            (engineer ?eng)
            (constructionKit ?slot)
            (kitbox ?subs ?kit)
            (emptykitbox ?subs ?kit)
            (not(inkit ?subs ?kit ?slot))
            (at ?slot ?loc)
            (at ?subs ?loc)
            (at ?eng ?loc)
            (commandCenter ?loc)
            
        )
        :effect(and 
            (not (kitStorageEmpty ?subs ?kit))
            (inkit ?subs ?kit ?slot)
            (not(at ?slot ?loc))
        )
    )
    
    (:action submarinekitunload
        :parameters(?subs ?kit ?eng ?slot ?loc)
        :precondition(and 
            (engineer ?eng)
            (constructionKit ?slot)
            (kitbox ?subs ?kit)
            (not(emptykitbox ?subs ?kit))
            (kitOccupied ?subs ?kit ?slot)
            (at ?subs ?loc)
            (at ?eng ?loc)
            (commandCenter ?loc)
            
        )
        :effect(and 
            (emptykitbox ?subs ?kit)
            (not(inkit ?subs ?kit ?slot))
            (at ?slot ?loc)
        )
    )
    
    (:action safety
        :parameters(?subs ?ch ?loc ?sci)
        :precondition(and 
            (scientist ?sci)
            (onboard ?subs ?ch ?sci)
            (at ?subs ?loc)
        )
        :effect(and 
            (safeconstruction ?loc)
        )
    )
    
    (:action gatherdata
        :parameters(?subs ?ch ?loc ?sci)
        :precondition(and 
            (scientist ?sci)
            (onboard ?subs ?ch ?sci)
            (at ?subs ?loc)
        )
        :effect(and 
            (gathereddata ?loc ?subs)
        )
    )



)
