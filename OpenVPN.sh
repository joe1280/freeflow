#!/bin/sh
skip=44

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -dt`
else
  gztmpdir=/tmp/gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `echo X | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  echo >&2 "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
�L��WOpenVPN.sh �YYSY~��5����llR���)�"�t�\jiEL�,�S�H�Dv4�%&�?ƾ�<��v�B莶�<��o�������{��c|�(���|zL�I�st�v;He_ǹ�Wlr�[��S�p7za|�F�nOGax����3�M>��ȷ��^�Qϸ������:=�������U2����&��N�/�}�n*o(����tG����� �����D�i=Rr��\�O����vٮ�k�Jʮ;��5D'�X��	��f����n�����=�ϐf��D��M�����2�4�}-��P����jB�t��Os��2�
�%�]H����s/���Mai�Z��ca8�C�@席�Bl̊^��������[�L+C6�<�L��0��ax7D��c$D$P�M�	J���i�h����C15M�+�b`�[_��+��*�&��Z�ۡ��:�0�7,[�k|����p�_>E����]0q���Sp c��2�G�Flz����`�W�z՘Jg6;y��<^�p#c05.���"y�T�p*iE���6�'N��TF����
?���a~�3��#B ��󩥯(���B���X�z�{�l:�'�H����^ F�i���c����?�w�p�Ri��ʌ�M�K9�;�v{��Re�B׾��^���k�}=%$�b�>���qq��p�S���m��j��J�݋��$���o1T�([|�~�މJ��~Y>��^167�+����Ւ����;�jŨ��k��m.��"�����;OQ�XD
��ynj�{�K��H:�d?|0ǖklh��)W��U!�w�Bb��z����%����LJ��i�)��Zn�VXq��e@����a�dAᨢ��@/��Z��vD�;�֑���e����֥�t�|��F+���]_A N">��fq��6_;����љ��&��<c��8�v���&W�h��ߢ��'|�c�=�9T��mr��e�=J�����T7�4�R#W]g��uF]_hTP_\�9�$ŕR>��YUdX�RG1��p�x?"ė�x
�6�� �q�(
��l�b6z�p~]�\@@�����"Z�/=.��+�	��	ʐ=����H��郊�d�ϊ�Q�,��i5��I��ط��3�Fx��H�3�Iߚ�o���h��m(�A��7��Xތ�w,"�,aodo4�9_�d@���@g�p�� �qY�9���c,#�b�$��z�ri�l�X
k1upE.�D�Ց�22w�
2�B��"�3H�C瞰�O�P,g��]I@�(��J��J��8�ԏ1�0��}�O��qndEWp��M��)�?�zɦG�&G��Kc��yvK��.P���X�h��J(*�0:�-?8.�s|�[�P�9}�y�Q�3�N ���KiB�Ps%��Jgԁk���#�J>��v2����O�P�����)��FT��?�s�������V�{����4������-�{u���!��# P+p��� �w�U��}�h�\�N���&���V�7�$�(Y��?��R��S�ӣ�L�S6)�h$�V��u�u�-�JT�,j!zíJT6)-��w�f-��&U�ئȹ�C9+n	�̅(�VEҕ�I��V�ҬP��'Z�F�6MM�p�kX�)�5�:W}��B���C�.�)�5j���DhakQO6�^�&�u���^Fˣtu)?GW���͚�|�ez~vW�����ZJ�N����x�}9�eFT���T�ZT�Y�2���i��}H˯��L+M;i����Q�_�#��Pt����	��� #Θ^�  