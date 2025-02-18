# shellcheck shell=sh disable=SC1008

amneziawg_depend()
{
	program awg
	after interface
}

amneziawg_pre_start()
{
	ebegin "Configuring amneziawg interface $IFACE"
	awg-quick up $IFACE 2>/dev/null
	e=$?
	eend $e
	return $e
}

amneziawg_post_stop()
{
	ebegin "Stopping amneziawg interface $IFACE"
	awg-quick down $IFACE 2>/dev/null
	e=$e
	eend $e
	return $e
}
