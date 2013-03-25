TR.CurRTime = 0;
TR.CurState = TR_STATE_BUILD

net.Receive( "TorrentTick", function( len )

	TR.CurRTime = net.ReadInt( 32 ); 

end);

net.Receive( "TorrentStateChanged", function( len )

	TR.CurState = net.ReadInt( 32 );

	if (TR.CurState == TR_STATE_BUILD) then 

		LocalPlayer():SetOrigMoney( LocalPlayer():GetMoney() );

	end 

end);

net.Receive( "TorrentCMoneyCache", function( len ) 

	LocalPlayer():SetMoney( net.ReadInt( 32 ) );

end);

net.Receive( "TorrentCCLCache", function( len ) 

	LocalPlayer():SetWins( net.ReadInt( 32 ) );
	LocalPlayer():SetLoses( net.ReadInt( 32 ) );

end);
