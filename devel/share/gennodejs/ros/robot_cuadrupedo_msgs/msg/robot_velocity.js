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

class robot_velocity {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.walk = null;
      this.velocity = null;
    }
    else {
      if (initObj.hasOwnProperty('walk')) {
        this.walk = initObj.walk
      }
      else {
        this.walk = false;
      }
      if (initObj.hasOwnProperty('velocity')) {
        this.velocity = initObj.velocity
      }
      else {
        this.velocity = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type robot_velocity
    // Serialize message field [walk]
    bufferOffset = _serializer.bool(obj.walk, buffer, bufferOffset);
    // Serialize message field [velocity]
    bufferOffset = _serializer.float64(obj.velocity, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type robot_velocity
    let len;
    let data = new robot_velocity(null);
    // Deserialize message field [walk]
    data.walk = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [velocity]
    data.velocity = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'robot_cuadrupedo_msgs/robot_velocity';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8bed2b6d4486708eb51d1d25b9ec31fb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool walk
    float64 velocity
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new robot_velocity(null);
    if (msg.walk !== undefined) {
      resolved.walk = msg.walk;
    }
    else {
      resolved.walk = false
    }

    if (msg.velocity !== undefined) {
      resolved.velocity = msg.velocity;
    }
    else {
      resolved.velocity = 0.0
    }

    return resolved;
    }
};

module.exports = robot_velocity;
