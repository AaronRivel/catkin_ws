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

class motors_states {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.leg1 = null;
      this.leg2 = null;
      this.leg3 = null;
      this.leg4 = null;
    }
    else {
      if (initObj.hasOwnProperty('leg1')) {
        this.leg1 = initObj.leg1
      }
      else {
        this.leg1 = new robot_cuadrupedo_msgs.msg.legs_control();
      }
      if (initObj.hasOwnProperty('leg2')) {
        this.leg2 = initObj.leg2
      }
      else {
        this.leg2 = new robot_cuadrupedo_msgs.msg.legs_control();
      }
      if (initObj.hasOwnProperty('leg3')) {
        this.leg3 = initObj.leg3
      }
      else {
        this.leg3 = new robot_cuadrupedo_msgs.msg.legs_control();
      }
      if (initObj.hasOwnProperty('leg4')) {
        this.leg4 = initObj.leg4
      }
      else {
        this.leg4 = new robot_cuadrupedo_msgs.msg.legs_control();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type motors_states
    // Serialize message field [leg1]
    bufferOffset = robot_cuadrupedo_msgs.msg.legs_control.serialize(obj.leg1, buffer, bufferOffset);
    // Serialize message field [leg2]
    bufferOffset = robot_cuadrupedo_msgs.msg.legs_control.serialize(obj.leg2, buffer, bufferOffset);
    // Serialize message field [leg3]
    bufferOffset = robot_cuadrupedo_msgs.msg.legs_control.serialize(obj.leg3, buffer, bufferOffset);
    // Serialize message field [leg4]
    bufferOffset = robot_cuadrupedo_msgs.msg.legs_control.serialize(obj.leg4, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type motors_states
    let len;
    let data = new motors_states(null);
    // Deserialize message field [leg1]
    data.leg1 = robot_cuadrupedo_msgs.msg.legs_control.deserialize(buffer, bufferOffset);
    // Deserialize message field [leg2]
    data.leg2 = robot_cuadrupedo_msgs.msg.legs_control.deserialize(buffer, bufferOffset);
    // Deserialize message field [leg3]
    data.leg3 = robot_cuadrupedo_msgs.msg.legs_control.deserialize(buffer, bufferOffset);
    // Deserialize message field [leg4]
    data.leg4 = robot_cuadrupedo_msgs.msg.legs_control.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 72;
  }

  static datatype() {
    // Returns string type for a message object
    return 'robot_cuadrupedo/motors_states';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c6779dc7494c3c55386a9358df1a0c6a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    robot_cuadrupedo_msgs/legs_control leg1
    
    robot_cuadrupedo_msgs/legs_control leg2
    
    robot_cuadrupedo_msgs/legs_control leg3
    
    robot_cuadrupedo_msgs/legs_control leg4
    ================================================================================
    MSG: robot_cuadrupedo_msgs/legs_control
    float64 frontal_motor
    float64 posterior_motor
    bool walk
    bool goal_position_feedback
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new motors_states(null);
    if (msg.leg1 !== undefined) {
      resolved.leg1 = robot_cuadrupedo_msgs.msg.legs_control.Resolve(msg.leg1)
    }
    else {
      resolved.leg1 = new robot_cuadrupedo_msgs.msg.legs_control()
    }

    if (msg.leg2 !== undefined) {
      resolved.leg2 = robot_cuadrupedo_msgs.msg.legs_control.Resolve(msg.leg2)
    }
    else {
      resolved.leg2 = new robot_cuadrupedo_msgs.msg.legs_control()
    }

    if (msg.leg3 !== undefined) {
      resolved.leg3 = robot_cuadrupedo_msgs.msg.legs_control.Resolve(msg.leg3)
    }
    else {
      resolved.leg3 = new robot_cuadrupedo_msgs.msg.legs_control()
    }

    if (msg.leg4 !== undefined) {
      resolved.leg4 = robot_cuadrupedo_msgs.msg.legs_control.Resolve(msg.leg4)
    }
    else {
      resolved.leg4 = new robot_cuadrupedo_msgs.msg.legs_control()
    }

    return resolved;
    }
};

module.exports = motors_states;
