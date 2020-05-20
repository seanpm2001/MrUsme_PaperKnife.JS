
address_list
    = sD:(address (address_split address)*) {

    var ret = [sD[0]];

    for(var i=0; i < sD[1].length; ++i)
    {
     ret.push( sD[1][i][1] );
    }
    return ret;
}
    / obs_addr_list

address
    = mailbox
    / group

mailbox
    = name_addr
    / addr_spec

name_addr
    = dn:display_name? aa:angle_addr {
    return [ dn[0],  aa[2][0], aa[2][1], (typeof aa[4][0][0] != "undefined" ? aa[4][0][0][1] : {}) ];
}

angle_addr
    = CFWS? "<" addr_spec ">" CFWS?
    / obs_angle_addr

group
    = display_name ":" (mailbox_list / CFWS? )? ";" CFWS?

display_name
    = phrase

phrase
    = ph:(word+) {

var str = "";
if(typeof ph[0].value == "undefined")
{
    for(var i = 0; i < ph.length; ++i)
    {
        str += ph[i][1].join("") + (i == ph.length - 1 ? "" : " ");
    }
}
else
{
    str = ph[0].value;
}
return [{ type: "displayname", value: str }];
} / ph:obs_phrase { return ph.join(""); }

obs_phrase
    = word (word / "." / WSP)*

mailbox_list
    = (mailbox ("," mailbox)*)
    / obs_mbox_list

addr_spec
    = lp:local_part "@" dm:domain
{ return [
                                { type: "localpart", value: lp[1] }, { type: "domain", value: dm[1] }
                            ]
}

local_part
    = dot_atom
    / quoted_string
    / obs_local_part

domain
    = dot_atom
    / domain_literal
    / obs_domain

domain_literal
    = "[" dcontent* "]"

dcontent
    = dtext
    / quoted_pair

dtext
    = NO_WS_CTL / [\x21-\x2f\x30-\x5a\x5e-\x7e]

obs_angle_addr
    = CFWS? "<" obs_route? addr_spec ">" CFWS?

obs_mbox_list
    = (mailbox? CFWS? "," CFWS?)+ mailbox?

obs_addr_list
    = (address? CFWS? "," CFWS?)+ address?

dot_atom
    = CFWS? dot_atom_text CFWS?

dot_atom_text
    = at:atext+ bt:("." atext+)*
{
     var str = at.join("");
    for(var i = 0; i < bt.length; ++i) {
        str += "." + bt[i][1].join("");
    }
    return str;
}

quoted_string
    = CFWS? '"' qstr:(FWS? qcontent)* FWS? '"' CFWS? {
     var str = "";
     for(var i = 0; i < qstr.length; ++i) {
            str += (qstr[i][0][1] == ' ' ? ' ' : '') + qstr[i][1];
     }
     return str;
}

obs_local_part
    = word ("." word)*

obs_domain
    = atom ("." atom)*

quoted_pair
    = ("\\" text)
    / obs_qp

NO_WS_CTL
    = [\x10-\x1f\x20\x30\x40\x50\x60\x70\x80\xb0\xc0\xe0\xf0\x7f]

obs_route
    = CFWS? obs_domain_list ":" CFWS?

atext
    = [a-zA-Z0-9\x21\x23-\x27\x2a\x2b\x2d\x2f\x3d\x3f\x5e-\x60\x7b-\x7e] / [\xc2\xa1-\xc2\xbf] / [\u00A1-\u00FF]

qcontent
    = qtext
    / quoted_pair

word
    = w:atom
    / w:quoted_string {
    return { type: "displayname" , value: w }
}

atom
    = CFWS? atext+ CFWS?

text
    = [\x10-\x7f\x80\x90\xb0\xc0\xd0\xe0\xf0]

obs_text

obs_qp
    = "\\" ([\x10-\x7f\x00\x80\x90\xa0\xb0\xc0\xd0\xe0\xf0]?)

obs_domain_list
    = "@" domain ((CFWS / ",")* CFWS? "@" domain)*

qtext
    =  NO_WS_CTL / [\x23-\x5b\x5d-\x7e\x21] / [\u00A1-\u00FF]

obs_text
    = LF* CR* (obs_char LF* CR*)*

LF
    = "\xa0"

CR
    = "\xd0"

CRLF
    = "\xd0\xa0"

obs_char
    = [\x10-\x7f\x00\x80\x90\xb0\xc0\xe0\xf0]

CFWS
    = (FWS? comment)* ((FWS? comment) / FWS)

FWS
    = (WSP* CRLF)? WSP+ / obs_FWS / ""

obs_FWS
    = WSP+ (CRLF WSP+)*

WSP
    = "\x20" / "\x90"

ctext
    =       NO_WS_CTL / [\x21-\x27\x2a-\x7e]

ccontent        =       ctext / quoted_pair / comment

comment         =       "(" cm:(FWS? ccontent)* FWS? ")" {
    var str = "";
    for(var i=0; i<cm.length; ++i)
    {
        str += cm[i][1];
    }
    return { type: "comment", value: str };
}

address_split =
 "," / ";"
