--[[
  PizzaFarm_AutoWork_v1  protected build
  Loader: fetch parts -> xor -> lzss -> run
]]
local _8aCI87z={
"https://raw.githubusercontent.com/fhuev12/PizzaFarm-Scripts/main/parts/PizzaFarm_AutoWork_v1.p1.txt",
"https://raw.githubusercontent.com/fhuev12/PizzaFarm-Scripts/main/parts/PizzaFarm_AutoWork_v1.p2.txt",
"https://raw.githubusercontent.com/fhuev12/PizzaFarm-Scripts/main/parts/PizzaFarm_AutoWork_v1.p3.txt"
}
local _m7apk2A={}
for _hslUBFh=1,#_8aCI87z do
  local _IbGnf5l=game:HttpGet(_8aCI87z[_hslUBFh])
  _m7apk2A[#_m7apk2A+1]=_IbGnf5l
end
local _8Tj51iQ=table.concat(_m7apk2A):gsub('%s+','')
local _542OOJk='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local _qa1x3xv={}
for _hslUBFh=1,#_542OOJk do _qa1x3xv[_542OOJk:sub(_hslUBFh,_hslUBFh)]=_hslUBFh-1 end
local function _TCWjTBs(_zdzclRj)
  local _0pOtBC4={}
  local _CVmeaEo=#_zdzclRj
  local _hslUBFh=1
  while _hslUBFh<=_CVmeaEo do
    local _JF4sNxc=_qa1x3xv[_zdzclRj:sub(_hslUBFh,_hslUBFh)]
    local _NTeGa6k=_qa1x3xv[_zdzclRj:sub(_hslUBFh+1,_hslUBFh+1)]
    local _MmRzyuW=_zdzclRj:sub(_hslUBFh+2,_hslUBFh+2)
    local _bwaOmmp=_zdzclRj:sub(_hslUBFh+3,_hslUBFh+3)
    local _qjXPH1q=(_MmRzyuW=='=') and -1 or _qa1x3xv[_MmRzyuW]
    local _TVTfhyi=(_bwaOmmp=='=') and -1 or _qa1x3xv[_bwaOmmp]
    if not (_JF4sNxc and _NTeGa6k) then break end
    _0pOtBC4[#_0pOtBC4+1]=string.char(_JF4sNxc*4+math.floor(_NTeGa6k/16))
    if _qjXPH1q and _qjXPH1q>=0 then
      _0pOtBC4[#_0pOtBC4+1]=string.char((_NTeGa6k%16)*16+math.floor(_qjXPH1q/4))
      if _TVTfhyi and _TVTfhyi>=0 then
        _0pOtBC4[#_0pOtBC4+1]=string.char((_qjXPH1q%4)*64+_TVTfhyi)
      end
    end
    _hslUBFh=_hslUBFh+4
  end
  return table.concat(_0pOtBC4)
end
local _LIzox1X='TxD0KG94Efz9FsA9WKJsZcOv6yO2'
local _2iDSU5u=bit32
local function _v65vlA2(_zdzclRj)
  local _0pOtBC4={}
  local _BY9LXZU=#_LIzox1X
  for _hslUBFh=1,#_zdzclRj do
    _0pOtBC4[_hslUBFh]=string.char(_2iDSU5u.bxor(string.byte(_zdzclRj,_hslUBFh),string.byte(_LIzox1X,(_hslUBFh-1)%_BY9LXZU+1)))
  end
  return table.concat(_0pOtBC4)
end
local function _1Mtd3Gn(_zdzclRj)
  local _0pOtBC4={}
  local _hslUBFh=1
  local _W5aP2pa=0
  local _8llJcnu=0
  while _hslUBFh<=#_zdzclRj do
    if _8llJcnu==0 then _W5aP2pa=string.byte(_zdzclRj,_hslUBFh);_hslUBFh=_hslUBFh+1;_8llJcnu=8 end
    if _2iDSU5u.band(_W5aP2pa,1)==1 then
      local _AIFP9nu=string.byte(_zdzclRj,_hslUBFh)*256+string.byte(_zdzclRj,_hslUBFh+1)
      local _JypFIVi=string.byte(_zdzclRj,_hslUBFh+2)
      _hslUBFh=_hslUBFh+3
      local _hz2NBHH=#_0pOtBC4-_AIFP9nu
      for _SgYScST=1,_JypFIVi do _0pOtBC4[#_0pOtBC4+1]=_0pOtBC4[_hz2NBHH+_SgYScST] end
    else
      _0pOtBC4[#_0pOtBC4+1]=string.sub(_zdzclRj,_hslUBFh,_hslUBFh)
      _hslUBFh=_hslUBFh+1
    end
    _W5aP2pa=_2iDSU5u.rshift(_W5aP2pa,1)
    _8llJcnu=_8llJcnu-1
  end
  return table.concat(_0pOtBC4)
end
local _EA9Sifo=_v65vlA2(_TCWjTBs(_8Tj51iQ))
local _JypFIVi=_2iDSU5u.band(string.byte(_EA9Sifo,1),255)+_2iDSU5u.lshift(_2iDSU5u.band(string.byte(_EA9Sifo,2),255),8)+_2iDSU5u.lshift(_2iDSU5u.band(string.byte(_EA9Sifo,3),255),16)+_2iDSU5u.lshift(_2iDSU5u.band(string.byte(_EA9Sifo,4),255),24)
local _EqhqG6k=string.sub(_EA9Sifo,5,4+_JypFIVi)
local _6S4k8aK=_1Mtd3Gn(_EqhqG6k)
local _SLboUUl=(loadstring or load)(_6S4k8aK,'@PizzaFarm_AutoWork_v1')
if not _SLboUUl then error('protected payload failed to load') end
_SLboUUl()
