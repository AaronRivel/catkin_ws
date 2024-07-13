// Auto-generated. Do not edit!

// (in-package robot_cuadrupedo.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let robot_cuadrupedo_msgs = _finder('robot_cuadrupedo_msgs');

//-----------------------------------------------------------

class robot_state {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.rc = null;
    }
    else {
      if (initObj.hasOwnProperty('rc')) {
        this.rc = initObj.rc
      }
      else {
        this.rc = new robot_cuadrupedo_msgs.msg.robot_velocity();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type robot_state
    // Serialize message field [rc]
    bufferOffset = robot_cuadrupedo_msgs.msg.robot_velocity.serialize(obj.rc, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type robot_state
    let len;
    let data = new robot_state(null);
    // Deserialize message field [rc]
    data.rc = robot_cuadrupedo_msgs.msg.robot_velocity.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'robot_cuadrupedo/robot_state';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4aab73bea9dabf128c8c483534d2bbfe';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    robot_cuadrupedo_msgs/robot_velocity rc
    ================================================================================
    MSG: robot_cuadrupedo_msgs/robot_velocity
    bool walk
    float64 velocity
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new robot_state(null);
    if (msg.rc !== undefined) {
      resolved.rc = robot_cuadrupedo_msgs.msg.robot_velocity.Resolve(msg.rc)
    }
    else {
      resolved.rc = new robot_cuadrupedo_msgs.msg.robot_velocity()
    }

    return resolved;
    }
};

module.exports = robot_state;
