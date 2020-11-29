<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="trig" />
        <signal name="reset" />
        <signal name="clk" />
        <signal name="ADDR" />
        <signal name="WR_RD" />
        <signal name="CS" />
        <signal name="DOUT" />
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <rect width="720" x="1472" y="900" height="724" />
        <text style="fontsize:52;fontname:Arial" x="1492" y="832">CPU gen</text>
        <branch name="trig">
            <attrtext style="alignment:SOFT-BCENTER;fontsize:28;fontname:Arial" attrname="Name" x="1248" y="1024" type="branch" />
            <wire x2="1248" y1="1024" y2="1024" x1="1216" />
            <wire x2="1472" y1="1024" y2="1024" x1="1248" />
        </branch>
        <branch name="reset">
            <attrtext style="alignment:SOFT-BCENTER;fontsize:28;fontname:Arial" attrname="Name" x="1248" y="1152" type="branch" />
            <wire x2="1248" y1="1152" y2="1152" x1="1216" />
            <wire x2="1472" y1="1152" y2="1152" x1="1248" />
        </branch>
        <branch name="clk">
            <attrtext style="alignment:SOFT-BCENTER;fontsize:28;fontname:Arial" attrname="Name" x="1248" y="1280" type="branch" />
            <wire x2="1248" y1="1280" y2="1280" x1="1216" />
            <wire x2="1472" y1="1280" y2="1280" x1="1248" />
        </branch>
        <branch name="ADDR">
            <attrtext style="alignment:SOFT-BCENTER;fontsize:28;fontname:Arial" attrname="Name" x="2448" y="1008" type="branch" />
            <wire x2="2448" y1="1008" y2="1008" x1="2208" />
            <wire x2="2464" y1="1008" y2="1008" x1="2448" />
        </branch>
        <branch name="WR_RD">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2448" y="1328" type="branch" />
            <wire x2="2448" y1="1328" y2="1328" x1="2192" />
        </branch>
        <branch name="CS">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2448" y="1152" type="branch" />
            <wire x2="2448" y1="1152" y2="1152" x1="2192" />
        </branch>
        <branch name="DOUT">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2448" y="1440" type="branch" />
            <wire x2="2448" y1="1440" y2="1440" x1="2192" />
        </branch>
    </sheet>
</drawing>