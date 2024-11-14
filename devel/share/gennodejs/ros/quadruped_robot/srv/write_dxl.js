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

class write_dxlRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.action = null;
      this.motor_f = null;
      this.motor_p = null;
      this.data_f = null;
      this.data_p = null;
    }
    else {
      if (initObj.hasOwnProperty('action')) {
        this.action = initObj.action
      }
      else {
        this.action = '';
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
      if (initObj.hasOwnProperty('data_f')) {
        this.data_f = initObj.data_f
      }
      else {
        this.data_f = 0.0;
      }
      if (initObj.hasOwnProperty('data_p')) {
        this.data_p = initObj.data_p
      }
      else {
        this.data_p = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type write_dxlRequest
    // Serialize message field [action]
    bufferOffset = _serializer.string(obj.action, buffer, bufferOffset);
    // Serialize message field [motor_f]
    bufferOffset = _serializer.int64(obj.motor_f, buffer, bufferOffset);
    // Serialize message field [motor_p]
    bufferOffset = _serializer.int64(obj.motor_p, buffer, bufferOffset);
    // Serialize message field [data_f]
    bufferOffset = _serializer.float64(obj.data_f, buffer, bufferOffset);
    // Serialize message field [data_p]
    bufferOffset = _serializer.float64(obj.data_p, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type write_dxlRequest
    let len;
    let data = new write_dxlRequest(null);
    // Deserialize message field [action]
    data.action = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [motor_f]
    data.motor_f = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [motor_p]
    data.motor_p = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [data_f]
    data.data_f = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [data_p]
    data.data_p = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.action);
    return length + 36;
  }

  static datatype() {
    // Returns string type for a service object
    return 'quadruped_robot/write_dxlRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '293427b285a218bd6787b43f62e792d3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string action
    int64 motor_f
    int64 motor_p
    float64 data_f
    float64 data_p
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new write_dxlRequest(null);
    if (msg.action !== undefined) {
      resolved.action = msg.action;
    }
    else {
      resolved.action = ''
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

    if (msg.data_f !== undefined) {
      resolved.data_f = msg.data_f;
    }
    else {
      resolved.data_f = 0.0
    }

    if (msg.data_p !== undefined) {
      resolved.data_p = msg.data_p;
    }
    else {
      resolved.data_p = 0.0
    }

    return resolved;
    }
};

class write_dxlResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.result = null;
    }
    else {
      if (initObj.hasOwnProperty('result')) {
        this.result = initObj.result
      }
      else {
        this.result = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type write_dxlResponse
    // Serialize message field [result]
    bufferOffset = _serializer.bool(obj.result, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type write_dxlResponse
    let len;
    let data = new write_dxlResponse(null);
    // Deserialize message field [result]
    data.result = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'quadruped_robot/write_dxlResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'eb13ac1f1354ccecb7941ee8fa2192e8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool result
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new write_dxlResponse(null);
    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = false
    }

    return resolved;
    }
};

module.exports = {
  Request: write_dxlRequest,
  Response: write_dxlResponse,
  md5sum() { return '428ef13fdd260581844722fd7a6d6e35'; },
  datatype() { return 'quadruped_robot/write_dxl'; }
};
