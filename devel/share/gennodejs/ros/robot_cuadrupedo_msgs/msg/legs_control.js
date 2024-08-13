// Auto-generated. Do not edit!

// (in-package robot_cuadrupedo_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class legs_control {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.frontal_motor = null;
      this.posterior_motor = null;
      this.walk = null;
      this.goal_position_feedback = null;
      this.id_f = null;
      this.id_p = null;
    }
    else {
      if (initObj.hasOwnProperty('frontal_motor')) {
        this.frontal_motor = initObj.frontal_motor
      }
      else {
        this.frontal_motor = 0.0;
      }
      if (initObj.hasOwnProperty('posterior_motor')) {
        this.posterior_motor = initObj.posterior_motor
      }
      else {
        this.posterior_motor = 0.0;
      }
      if (initObj.hasOwnProperty('walk')) {
        this.walk = initObj.walk
      }
      else {
        this.walk = false;
      }
      if (initObj.hasOwnProperty('goal_position_feedback')) {
        this.goal_position_feedback = initObj.goal_position_feedback
      }
      else {
        this.goal_position_feedback = false;
      }
      if (initObj.hasOwnProperty('id_f')) {
        this.id_f = initObj.id_f
      }
      else {
        this.id_f = 0;
      }
      if (initObj.hasOwnProperty('id_p')) {
        this.id_p = initObj.id_p
      }
      else {
        this.id_p = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type legs_control
    // Serialize message field [frontal_motor]
    bufferOffset = _serializer.float64(obj.frontal_motor, buffer, bufferOffset);
    // Serialize message field [posterior_motor]
    bufferOffset = _serializer.float64(obj.posterior_motor, buffer, bufferOffset);
    // Serialize message field [walk]
    bufferOffset = _serializer.bool(obj.walk, buffer, bufferOffset);
    // Serialize message field [goal_position_feedback]
    bufferOffset = _serializer.bool(obj.goal_position_feedback, buffer, bufferOffset);
    // Serialize message field [id_f]
    bufferOffset = _serializer.int64(obj.id_f, buffer, bufferOffset);
    // Serialize message field [id_p]
    bufferOffset = _serializer.int64(obj.id_p, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type legs_control
    let len;
    let data = new legs_control(null);
    // Deserialize message field [frontal_motor]
    data.frontal_motor = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [posterior_motor]
    data.posterior_motor = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [walk]
    data.walk = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [goal_position_feedback]
    data.goal_position_feedback = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [id_f]
    data.id_f = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [id_p]
    data.id_p = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 34;
  }

  static datatype() {
    // Returns string type for a message object
    return 'robot_cuadrupedo_msgs/legs_control';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '889997f071d49233501da79c98b3e3ac';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 frontal_motor
    float64 posterior_motor
    bool walk
    bool goal_position_feedback
    int64 id_f
    int64 id_p
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new legs_control(null);
    if (msg.frontal_motor !== undefined) {
      resolved.frontal_motor = msg.frontal_motor;
    }
    else {
      resolved.frontal_motor = 0.0
    }

    if (msg.posterior_motor !== undefined) {
      resolved.posterior_motor = msg.posterior_motor;
    }
    else {
      resolved.posterior_motor = 0.0
    }

    if (msg.walk !== undefined) {
      resolved.walk = msg.walk;
    }
    else {
      resolved.walk = false
    }

    if (msg.goal_position_feedback !== undefined) {
      resolved.goal_position_feedback = msg.goal_position_feedback;
    }
    else {
      resolved.goal_position_feedback = false
    }

    if (msg.id_f !== undefined) {
      resolved.id_f = msg.id_f;
    }
    else {
      resolved.id_f = 0
    }

    if (msg.id_p !== undefined) {
      resolved.id_p = msg.id_p;
    }
    else {
      resolved.id_p = 0
    }

    return resolved;
    }
};

module.exports = legs_control;
