;; Auto-generated. Do not edit!


(when (boundp 'quadruped_robot::motor_state)
  (if (not (find-package "QUADRUPED_ROBOT"))
    (make-package "QUADRUPED_ROBOT"))
  (shadow 'motor_state (find-package "QUADRUPED_ROBOT")))
(unless (find-package "QUADRUPED_ROBOT::MOTOR_STATE")
  (make-package "QUADRUPED_ROBOT::MOTOR_STATE"))

(in-package "ROS")
;;//! \htmlinclude motor_state.msg.html


(defclass quadruped_robot::motor_state
  :super ros::object
  :slots (_frontal_motor _posterior_motor _walk _goal_position_feedback _id_f _id_p ))

(defmethod quadruped_robot::motor_state
  (:init
   (&key
    ((:frontal_motor __frontal_motor) 0.0)
    ((:posterior_motor __posterior_motor) 0.0)
    ((:walk __walk) nil)
    ((:goal_position_feedback __goal_position_feedback) nil)
    ((:id_f __id_f) 0)
    ((:id_p __id_p) 0)
    )
   (send-super :init)
   (setq _frontal_motor (float __frontal_motor))
   (setq _posterior_motor (float __posterior_motor))
   (setq _walk __walk)
   (setq _goal_position_feedback __goal_position_feedback)
   (setq _id_f (round __id_f))
   (setq _id_p (round __id_p))
   self)
  (:frontal_motor
   (&optional __frontal_motor)
   (if __frontal_motor (setq _frontal_motor __frontal_motor)) _frontal_motor)
  (:posterior_motor
   (&optional __posterior_motor)
   (if __posterior_motor (setq _posterior_motor __posterior_motor)) _posterior_motor)
  (:walk
   (&optional (__walk :null))
   (if (not (eq __walk :null)) (setq _walk __walk)) _walk)
  (:goal_position_feedback
   (&optional (__goal_position_feedback :null))
   (if (not (eq __goal_position_feedback :null)) (setq _goal_position_feedback __goal_position_feedback)) _goal_position_feedback)
  (:id_f
   (&optional __id_f)
   (if __id_f (setq _id_f __id_f)) _id_f)
  (:id_p
   (&optional __id_p)
   (if __id_p (setq _id_p __id_p)) _id_p)
  (:serialization-length
   ()
   (+
    ;; float64 _frontal_motor
    8
    ;; float64 _posterior_motor
    8
    ;; bool _walk
    1
    ;; bool _goal_position_feedback
    1
    ;; int64 _id_f
    8
    ;; int64 _id_p
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _frontal_motor
       (sys::poke _frontal_motor (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _posterior_motor
       (sys::poke _posterior_motor (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool _walk
       (if _walk (write-byte -1 s) (write-byte 0 s))
     ;; bool _goal_position_feedback
       (if _goal_position_feedback (write-byte -1 s) (write-byte 0 s))
     ;; int64 _id_f
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _id_f (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _id_f) (= (length (_id_f . bv)) 2)) ;; bignum
              (write-long (ash (elt (_id_f . bv) 0) 0) s)
              (write-long (ash (elt (_id_f . bv) 1) -1) s))
             ((and (class _id_f) (= (length (_id_f . bv)) 1)) ;; big1
              (write-long (elt (_id_f . bv) 0) s)
              (write-long (if (>= _id_f 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _id_f s)(write-long (if (>= _id_f 0) 0 #xffffffff) s)))
     ;; int64 _id_p
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _id_p (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _id_p) (= (length (_id_p . bv)) 2)) ;; bignum
              (write-long (ash (elt (_id_p . bv) 0) 0) s)
              (write-long (ash (elt (_id_p . bv) 1) -1) s))
             ((and (class _id_p) (= (length (_id_p . bv)) 1)) ;; big1
              (write-long (elt (_id_p . bv) 0) s)
              (write-long (if (>= _id_p 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _id_p s)(write-long (if (>= _id_p 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _frontal_motor
     (setq _frontal_motor (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _posterior_motor
     (setq _posterior_motor (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool _walk
     (setq _walk (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _goal_position_feedback
     (setq _goal_position_feedback (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _id_f
#+(or :alpha :irix6 :x86_64)
      (setf _id_f (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _id_f (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _id_p
#+(or :alpha :irix6 :x86_64)
      (setf _id_p (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _id_p (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(setf (get quadruped_robot::motor_state :md5sum-) "889997f071d49233501da79c98b3e3ac")
(setf (get quadruped_robot::motor_state :datatype-) "quadruped_robot/motor_state")
(setf (get quadruped_robot::motor_state :definition-)
      "float64 frontal_motor
float64 posterior_motor
bool walk
bool goal_position_feedback
int64 id_f
int64 id_p
")



(provide :quadruped_robot/motor_state "889997f071d49233501da79c98b3e3ac")


