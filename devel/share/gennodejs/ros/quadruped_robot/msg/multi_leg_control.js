// Auto-generated. Do not edit!

// (in-package quadruped_robot.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let leg_state = require('./leg_state.js');

//-----------------------------------------------------------

class multi_leg_control {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.T = null;
      this.L1 = null;
      this.L2 = null;
      this.L3 = null;
      this.L4 = null;
    }
    else {
      if (initObj.hasOwnProperty('T')) {
        this.T = initObj.T
      }
      else {
        this.T = 0.0;
      }
      if (initObj.hasOwnProperty('L1')) {
        this.L1 = initObj.L1
      }
      else {
        this.L1 = new leg_state();
      }
      if (initObj.hasOwnProperty('L2')) {
        this.L2 = initObj.L2
      }
      else {
        this.L2 = new leg_state();
      }
      if (initObj.hasOwnProperty('L3')) {
        this.L3 = initObj.L3
      }
      else {
        this.L3 = new leg_state();
      }
      if (initObj.hasOwnProperty('L4')) {
        this.L4 = initObj.L4
      }
      else {
        this.L4 = new leg_state();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type multi_leg_control
    // Serialize message field [T]
    bufferOffset = _serializer.float64(obj.T, buffer, bufferOffset);
    // Serialize message field [L1]
    bufferOffset = leg_state.serialize(obj.L1, buffer, bufferOffset);
    // Serialize message field [L2]
    bufferOffset = leg_state.serialize(obj.L2, buffer, bufferOffset);
    // Serialize message field [L3]
    bufferOffset = leg_state.serialize(obj.L3, buffer, bufferOffset);
    // Serialize message field [L4]
    bufferOffset = leg_state.serialize(obj.L4, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type multi_leg_control
    let len;
    let data = new multi_leg_control(null);
    // Deserialize message field [T]
    data.T = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [L1]
    data.L1 = leg_state.deserialize(buffer, bufferOffset);
    // Deserialize message field [L2]
    data.L2 = leg_state.deserialize(buffer, bufferOffset);
    // Deserialize message field [L3]
    data.L3 = leg_state.deserialize(buffer, bufferOffset);
    // Deserialize message field [L4]
    data.L4 = leg_state.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += leg_state.getMessageSize(object.L1);
    length += leg_state.getMessageSize(object.L2);
    length += leg_state.getMessageSize(object.L3);
    length += leg_state.getMessageSize(object.L4);
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'quadruped_robot/multi_leg_control';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '06bad1c9b39c7b841c47d0fd74cc8b34';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 T
    leg_state L1
    leg_state L2
    leg_state L3
    leg_state L4
    ================================================================================
    MSG: quadruped_robot/leg_state
    float64 t
    float64 q0
    float64 q1
    float64 q0_dot
    float64 q1_dot
    string leg_pos
    bool walk_flag
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new multi_leg_control(null);
    if (msg.T !== undefined) {
      resolved.T = msg.T;
    }
    else {
      resolved.T = 0.0
    }

    if (msg.L1 !== undefined) {
      resolved.L1 = leg_state.Resolve(msg.L1)
    }
    else {
      resolved.L1 = new leg_state()
    }

    if (msg.L2 !== undefined) {
      resolved.L2 = leg_state.Resolve(msg.L2)
    }
    else {
      resolved.L2 = new leg_state()
    }

    if (msg.L3 !== undefined) {
      resolved.L3 = leg_state.Resolve(msg.L3)
    }
    else {
      resolved.L3 = new leg_state()
    }

    if (msg.L4 !== undefined) {
      resolved.L4 = leg_state.Resolve(msg.L4)
    }
    else {
      resolved.L4 = new leg_state()
    }

    return resolved;
    }
};

module.exports = multi_leg_control;
