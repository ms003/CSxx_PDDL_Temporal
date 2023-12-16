(define (domain basic_logistics)
(:requirements :strips :typing :numeric-fluents :durative-actions :timed-initial-literals )
    
    (:types 
        location locatable - object
        package truck driver plane boat - locatable
        

    

        
    )
    
    (:predicates
        (connected ?from ?to - location)
        (flyplane ?from ?to - location)
        (sailboat ?from ?to - location)
        (at ?o - locatable ?l - location)
        (in ?p - package ?o - locatable)
        (driving ?d - driver ?t - truck)
        (available ?p - package)
      
    )
    
    (:functions 
        (distance ?from ?to - location)
        (fly ?from ?to - location)
        (sail ?from ?to - location)
        (sail_speed ?b - boat)
        (fly_speed ?pl - plane)
        (drive_speed ?t - truck)
        (walk_speed ?d - driver)

    
    )
    
    ;;================;;
    ;; driver actions ;;
    ;;================;;
    
 

    (:durative-action walk
      :parameters (?d - driver ?from ?to - location)
      :duration (= ?duration ( / (distance ?from ?to) (walk_speed ?d)))
      :condition (and
        (at start (at ?d ?from))
        (over all (connected ?from ?to))
      )
      :effect (and
        (at start (not (at ?d ?from)))
        (at end (at ?d ?to))
      )
    )
    
    (:durative-action board_truck
      :parameters (?t - truck ?d - driver ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start(at ?d ?wp))
        (over all (at ?t ?wp))
      )
      :effect (and
        (at start (not (at ?d ?wp)))
        (at end (driving ?d ?t))
      )
    )
    
    (:durative-action disembark_truck
      :parameters (?t - truck ?d - driver ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (driving ?d ?t))
        (over all (at ?t ?wp))
      )
      :effect (and
        (at start (not (driving ?d ?t)))
        (at end (at ?d ?wp))
      )
    )
    
    ;;=================;;
    ;; vehicle actions ;;
    ;;=================;;

    
    (:durative-action fly_plane
        :parameters (?pl - plane ?from ?to  - location)
        :duration (= ?duration ( / (fly ?from ?to)(fly_speed ?pl)))
        :condition (and 
          (at start (at ?pl ?from))
          (over all (flyplane ?from ?to))
        )
        :effect (and 
        (at start (not (at ?pl ?from)))
        (at end (at ?pl ?to))
        )
        
        
    )

    (:durative-action sail_boat
      :parameters (?b -boat ?from ?to  -location)
      :duration (= ?duration ( / (sail ?from ?to) (sail_speed ?b)))
      :condition (and 
          (at start (at ?b ?from))
          (over all (sailboat ?from ?to))
        )
        :effect (and 
        (at start (not (at ?b ?from)))
        (at end (at ?b ?to))
        )
        
        
    )  

    (:durative-action drive_truck
      :parameters (?t - truck ?d - driver ?from ?to - location)
      :duration (= ?duration (/ (distance ?from ?to)(drive_speed ?t) ))
      :condition (and
        (at start (at ?t ?from))
        (over all (connected ?from ?to))
        (over all (driving ?d ?t))
      )
      :effect (and
        (at start (not (at ?t ?from)))
        (at end (at ?t ?to))
      )
    )
    
    ;;=================;;
    ;; package actions ;;
    ;;=================;;
    
    (:durative-action load_package_truck
      :parameters (?t - truck ?p - package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (at ?p ?wp))
        (over all (at ?t ?wp))
      
      )
      :effect (and
        (at start (not (at ?p ?wp)))
        (at end (in ?p ?t))
    
      )
    )
    
    (:durative-action unload_package_truck
      :parameters (?t -truck ?p - package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (in ?p ?t))
        (over all (at ?t ?wp))
        (over all (available ?p))
       ;;;deadline not passed
      )
      :effect (and
        (at start (not (in ?p ?t)))
        (at end (at ?p ?wp))
      )
    
    
    )

    (:durative-action load_package_plane
      :parameters (?pl - plane ?p - package ?wp -location)
      :duration (= ?duration 10)
      :condition (and
        (at start (at ?p ?wp))
        (over all (at ?pl ?wp))
        
      )
      :effect (and
        (at start (not (at ?p ?wp)))
        (at end (in ?p ?pl))
    
      )
    )
    
    (:durative-action unload_package_plane
      :parameters (?pl -plane ?p -package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (in ?p ?pl))
        (over all (at ?pl ?wp))
        (over all (available ?p))

        )
      :effect (and
        (at start (not (in ?p ?pl)))
        (at end (at ?p ?wp))
      )
    
    
    )
    
    (:durative-action load_package_boat
      :parameters (?b - boat ?p - package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (at ?p ?wp))
        (over all (at ?b ?wp))
      
      )
      :effect (and
        (at start (not (at ?p ?wp)))
        (at end (in ?p ?b))
    
      )
    )
    
    (:durative-action unload_package_boat
      :parameters (?b - boat ?p - package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (in ?p ?b))
        (over all (at ?b ?wp))
        (over all (available ?p))

        )
      :effect (and
        (at start (not (in ?p ?b)))
        (at end (at ?p ?wp))
      ) 
    
    )

    )

)