# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from quadruped_robot/leg_state.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class leg_state(genpy.Message):
  _md5sum = "65639cae4a56ecaed05a54ec9094a72f"
  _type = "quadruped_robot/leg_state"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """float64 t
float64 q0
float64 q1
string path
bool finish"""
  __slots__ = ['t','q0','q1','path','finish']
  _slot_types = ['float64','float64','float64','string','bool']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       t,q0,q1,path,finish

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(leg_state, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.t is None:
        self.t = 0.
      if self.q0 is None:
        self.q0 = 0.
      if self.q1 is None:
        self.q1 = 0.
      if self.path is None:
        self.path = ''
      if self.finish is None:
        self.finish = False
    else:
      self.t = 0.
      self.q0 = 0.
      self.q1 = 0.
      self.path = ''
      self.finish = False

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_3d().pack(_x.t, _x.q0, _x.q1))
      _x = self.path
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self.finish
      buff.write(_get_struct_B().pack(_x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      _x = self
      start = end
      end += 24
      (_x.t, _x.q0, _x.q1,) = _get_struct_3d().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.path = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.path = str[start:end]
      start = end
      end += 1
      (self.finish,) = _get_struct_B().unpack(str[start:end])
      self.finish = bool(self.finish)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_3d().pack(_x.t, _x.q0, _x.q1))
      _x = self.path
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self.finish
      buff.write(_get_struct_B().pack(_x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      _x = self
      start = end
      end += 24
      (_x.t, _x.q0, _x.q1,) = _get_struct_3d().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.path = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.path = str[start:end]
      start = end
      end += 1
      (self.finish,) = _get_struct_B().unpack(str[start:end])
      self.finish = bool(self.finish)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_3d = None
def _get_struct_3d():
    global _struct_3d
    if _struct_3d is None:
        _struct_3d = struct.Struct("<3d")
    return _struct_3d
_struct_B = None
def _get_struct_B():
    global _struct_B
    if _struct_B is None:
        _struct_B = struct.Struct("<B")
    return _struct_B
