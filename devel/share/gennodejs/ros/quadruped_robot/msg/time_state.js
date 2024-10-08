// Auto-generated. Do not edit!

// (in-package quadruped_robot.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class time_state {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.t = null;
      this.q0 = null;
      this.q1 = null;
      this.q0_dot = null;
      this.q1_dot = null;
    }
    else {
      if (initObj.hasOwnProperty('t')) {
        this.t = initObj.t
      }
      else {
        this.t = 0.0;
      }
      if (initObj.hasOwnProperty('q0')) {
        this.q0 = initObj.q0
      }
      else {
        this.q0 = 0.0;
      }
      if (initObj.hasOwnProperty('q1')) {
        this.q1 = initObj.q1
      }
      else {
        this.q1 = 0.0;
      }
      if (initObj.hasOwnProperty('q0_dot')) {
        this.q0_dot = initObj.q0_dot
      }
      else {
        this.q0_dot = 0.0;
      }
      if (initObj.hasOwnProperty('q1_dot')) {
        this.q1_dot = initObj.q1_dot
      }
      else {
        this.q1_dot = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type time_state
    // Serialize message field [t]
    bufferOffset = _serializer.float64(obj.t, buffer, bufferOffset);
    // Serialize message field [q0]
    bufferOffset = _serializer.float64(obj.q0, buffer, bufferOffset);
    // Serialize message field [q1]
    bufferOffset = _serializer.float64(obj.q1, buffer, bufferOffset);
    // Serialize message field [q0_dot]
    bufferOffset = _serializer.float64(obj.q0_dot, buffer, bufferOffset);
    // Serialize message field [q1_dot]
    bufferOffset = _serializer.float64(obj.q1_dot, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type time_state
    let len;
    let data = new time_state(null);
    // Deserialize message field [t]
    data.t = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [q0]
    data.q0 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [q1]
    data.q1 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [q0_dot]
    data.q0_dot = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [q1_dot]
    data.q1_dot = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 40;
  }

  static datatype() {
    // Returns string type for a message object
    return 'quadruped_robot/time_state';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fdf95eab8e31bbe478f129be831ec16a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 t
    float64 q0
    float64 q1
    float64 q0_dot
    float64 q1_dot
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new time_state(null);
    if (msg.t !== undefined) {
      resolved.t = msg.t;
    }
    else {
      resolved.t = 0.0
    }

    if (msg.q0 !== undefined) {
      resolved.q0 = msg.q0;
    }
    else {
      resolved.q0 = 0.0
    }

    if (msg.q1 !== undefined) {
      resolved.q1 = msg.q1;
    }
    else {
      resolved.q1 = 0.0
    }

    if (msg.q0_dot !== undefined) {
      resolved.q0_dot = msg.q0_dot;
    }
    else {
      resolved.q0_dot = 0.0
    }

    if (msg.q1_dot !== undefined) {
      resolved.q1_dot = msg.q1_dot;
    }
    else {
      resolved.q1_dot = 0.0
    }

    return resolved;
    }
};

module.exports = time_state;
