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

class period {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.T = null;
    }
    else {
      if (initObj.hasOwnProperty('T')) {
        this.T = initObj.T
      }
      else {
        this.T = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type period
    // Serialize message field [T]
    bufferOffset = _serializer.float64(obj.T, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type period
    let len;
    let data = new period(null);
    // Deserialize message field [T]
    data.T = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'quadruped_robot/period';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'df792c00269de90b579eb8eab6fc9c54';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 T
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new period(null);
    if (msg.T !== undefined) {
      resolved.T = msg.T;
    }
    else {
      resolved.T = 0.0
    }

    return resolved;
    }
};

module.exports = period;
