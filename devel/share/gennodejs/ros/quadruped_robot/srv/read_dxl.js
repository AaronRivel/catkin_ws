// Auto-generated. Do not edit!

// (in-package quadruped_robot.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class read_dxlRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.action = null;
      this.protocol_version = null;
      this.motor_f = null;
      this.motor_p = null;
    }
    else {
      if (initObj.hasOwnProperty('action')) {
        this.action = initObj.action
      }
      else {
        this.action = '';
      }
      if (initObj.hasOwnProperty('protocol_version')) {
        this.protocol_version = initObj.protocol_version
      }
      else {
        this.protocol_version = 0;
      }
      if (initObj.hasOwnProperty('motor_f')) {
        this.motor_f = initObj.motor_f
      }
      else {
        this.motor_f = 0;
      }
      if (initObj.hasOwnProperty('motor_p')) {
        this.motor_p = initObj.motor_p
      }
      else {
        this.motor_p = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type read_dxlRequest
    // Serialize message field [action]
    bufferOffset = _serializer.string(obj.action, buffer, bufferOffset);
    // Serialize message field [protocol_version]
    bufferOffset = _serializer.int64(obj.protocol_version, buffer, bufferOffset);
    // Serialize message field [motor_f]
    bufferOffset = _serializer.int64(obj.motor_f, buffer, bufferOffset);
    // Serialize message field [motor_p]
    bufferOffset = _serializer.int64(obj.motor_p, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type read_dxlRequest
    let len;
    let data = new read_dxlRequest(null);
    // Deserialize message field [action]
    data.action = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [protocol_version]
    data.protocol_version = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [motor_f]
    data.motor_f = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [motor_p]
    data.motor_p = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.action);
    return length + 28;
  }

  static datatype() {
    // Returns string type for a service object
    return 'quadruped_robot/read_dxlRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3e65dbf60554709c4068494151354d56';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string action
    int64 protocol_version
    int64 motor_f
    int64 motor_p
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new read_dxlRequest(null);
    if (msg.action !== undefined) {
      resolved.action = msg.action;
    }
    else {
      resolved.action = ''
    }

    if (msg.protocol_version !== undefined) {
      resolved.protocol_version = msg.protocol_version;
    }
    else {
      resolved.protocol_version = 0
    }

    if (msg.motor_f !== undefined) {
      resolved.motor_f = msg.motor_f;
    }
    else {
      resolved.motor_f = 0
    }

    if (msg.motor_p !== undefined) {
      resolved.motor_p = msg.motor_p;
    }
    else {
      resolved.motor_p = 0
    }

    return resolved;
    }
};

class read_dxlResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.result_1 = null;
      this.result_2 = null;
    }
    else {
      if (initObj.hasOwnProperty('result_1')) {
        this.result_1 = initObj.result_1
      }
      else {
        this.result_1 = 0;
      }
      if (initObj.hasOwnProperty('result_2')) {
        this.result_2 = initObj.result_2
      }
      else {
        this.result_2 = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type read_dxlResponse
    // Serialize message field [result_1]
    bufferOffset = _serializer.int64(obj.result_1, buffer, bufferOffset);
    // Serialize message field [result_2]
    bufferOffset = _serializer.int64(obj.result_2, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type read_dxlResponse
    let len;
    let data = new read_dxlResponse(null);
    // Deserialize message field [result_1]
    data.result_1 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [result_2]
    data.result_2 = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'quadruped_robot/read_dxlResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '576860b30f3ab6552ab3ffead7c691b3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int64 result_1
    int64 result_2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new read_dxlResponse(null);
    if (msg.result_1 !== undefined) {
      resolved.result_1 = msg.result_1;
    }
    else {
      resolved.result_1 = 0
    }

    if (msg.result_2 !== undefined) {
      resolved.result_2 = msg.result_2;
    }
    else {
      resolved.result_2 = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: read_dxlRequest,
  Response: read_dxlResponse,
  md5sum() { return '7620a6746ee96b998e0b60d728607979'; },
  datatype() { return 'quadruped_robot/read_dxl'; }
};
