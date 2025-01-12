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

class leg_state {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.t = null;
      this.q0 = null;
      this.q1 = null;
      this.gate = null;
      this.finish = null;
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
      if (initObj.hasOwnProperty('gate')) {
        this.gate = initObj.gate
      }
      else {
        this.gate = '';
      }
      if (initObj.hasOwnProperty('finish')) {
        this.finish = initObj.finish
      }
      else {
        this.finish = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type leg_state
    // Serialize message field [t]
    bufferOffset = _serializer.float64(obj.t, buffer, bufferOffset);
    // Serialize message field [q0]
    bufferOffset = _serializer.float64(obj.q0, buffer, bufferOffset);
    // Serialize message field [q1]
    bufferOffset = _serializer.float64(obj.q1, buffer, bufferOffset);
    // Serialize message field [gate]
    bufferOffset = _serializer.string(obj.gate, buffer, bufferOffset);
    // Serialize message field [finish]
    bufferOffset = _serializer.bool(obj.finish, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type leg_state
    let len;
    let data = new leg_state(null);
    // Deserialize message field [t]
    data.t = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [q0]
    data.q0 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [q1]
    data.q1 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [gate]
    data.gate = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [finish]
    data.finish = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.gate);
    return length + 29;
  }

  static datatype() {
    // Returns string type for a message object
    return 'quadruped_robot/leg_state';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0aee4478960f31ac1b388a2ea0e849cd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 t
    float64 q0
    float64 q1
    string gate
    bool finish
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new leg_state(null);
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

    if (msg.gate !== undefined) {
      resolved.gate = msg.gate;
    }
    else {
      resolved.gate = ''
    }

    if (msg.finish !== undefined) {
      resolved.finish = msg.finish;
    }
    else {
      resolved.finish = false
    }

    return resolved;
    }
};

module.exports = leg_state;
