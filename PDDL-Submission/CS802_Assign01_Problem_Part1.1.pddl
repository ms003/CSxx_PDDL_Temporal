(define (problem problem_logistics)
(:domain basic_logistics)
(:requirements :strips :typing :equality :numeric-fluents :durative-actions :timed-initial-literals)

    (:objects 
        wp1 wp2 wp3 wp4 wp5 wp6 wp7 wp8 wp9 wp10 wp11 lighthouse sky - location
        t1 t2 - truck
        dr1 dr2 - driver
        pack1 pack2 pack3 pack4 - package
        b - boat
        pl - plane 
    )
    
    (:init
        ;; drivers
        (at dr1 wp4)
        (at dr2 wp1)
        
        ;; trucks
        (at t1 wp6)
        (at t2 wp9)
        
        ;; packages
        (at pack1 wp2)
        (at pack2 wp3)
        (at pack3 wp5)
        (at pack4 wp11)
        
        ;;boat and place
        (at b lighthouse)
        (at pl sky)
        
        ;; Ground Connections
        (connected wp1 wp2)     (= (distance wp1 wp2) 100)
        (connected wp2 wp1)     (= (distance wp2 wp1) 100)
        (connected wp2 wp3)     (= (distance wp2 wp3) 100)
        (connected wp3 wp2)     (= (distance wp3 wp2) 100)
        (connected wp3 wp8)     (= (distance wp3 wp8) 75)
        (connected wp8 wp3)     (= (distance wp8 wp3) 75)
        (connected wp8 wp11)    (= (distance wp8 wp11) 75)
        
        (connected wp11 wp8)    (= (distance wp11 wp8) 75)
        (connected wp11 wp10)   (= (distance wp11 wp10) 100)
        (connected wp10 wp11)   (= (distance wp10 wp11) 100)
        (connected wp10 wp9)    (= (distance wp10 wp9) 100)
        (connected wp9 wp10)    (= (distance wp9 wp10) 100)
        (connected wp9 wp4)     (= (distance wp9 wp4) 75)
        (connected wp4 wp9)     (= (distance wp4 wp9) 75)
        (connected wp4 wp1)     (= (distance wp4 wp1) 75)
        (connected wp1 wp4)     (= (distance wp1 wp4) 75)
        (connected wp1 wp5)     (= (distance wp1 wp5) 100)
        (connected wp5 wp1)     (= (distance wp5 wp1) 100)
        (connected wp5 wp6)     (= (distance wp5 wp6) 50)
        (connected wp6 wp5)     (= (distance wp6 wp5) 50)
        (connected wp6 wp7)     (= (distance wp6 wp7) 50)
        (connected wp7 wp6)     (= (distance wp7 wp6) 50)
        (connected wp2 wp6)     (= (distance wp2 wp6) 75)
        (connected wp6 wp2)     (= (distance wp6 wp2) 75)
        (flyplane wp4 sky)      (= (fly wp4 sky) 20)
        (flyplane sky wp4)      (= (fly sky wp4) 20)
        (flyplane sky wp2)      (= (fly sky wp2) 20)
        (flyplane wp2 sky)      (= (fly wp2 sky) 20)
        (sailboat lighthouse wp7)   (= (sail lighthouse wp7) 75)
        (sailboat wp7 lighthouse)   (= (sail wp7 lighthouse) 75)

       ;; speeds

       (= (sail_speed b) 1.5)
       (= (fly_speed pl) 2)
       (= (drive_speed t1) 1)
       (= (drive_speed t2) 1)
       (= (walk_speed dr1) 0.5)
       (= (walk_speed dr2) 0.5)

        (available pack1)
        (available pack2)
        (available pack3)
        (available pack4)
         
        
    )

    (:goal (and 
        ;; drivers home
       (at dr1 wp1)
       (at dr2 wp1)
        
        
        ;; packages delivered
        (at pack1 wp9)
        (at pack2 lighthouse)
        (at pack3 wp9)
        (at pack4 wp2)
    ))
)