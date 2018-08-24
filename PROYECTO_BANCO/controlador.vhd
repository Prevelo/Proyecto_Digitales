LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY controlador IS
	PORT(clock,reset,start,tecla,passw_in,ID_in,deposito_in,debito_in,
	     acreditar_valor,debito,consultar_saldo,cambiar_clave,aceptar,borrar,
		  ok_ID,ok_passw,stop_R,deposito_OK,debito_OK,val_resta,consulta_OK,
		  cont_3s,cont_5s,ultima,stop_PS,nxt: IN STD_LOGIC;
		  error,verde,enRegA,resetRA,enDT,resetD,enRegB,resetRB,
		  w_saldo,w_passw,enAdd,resetAdd,endeco,select_DP,
		  select_mux,enRegC,resetDP,enT,resetT,resetPS,resetOC,ldPS,enOC,
		  enPS,selPS,selN, ingre_ID, ingre_PASS, elig_OP,inicio,ensald,rsald: OUT STD_LOGIC);
END controlador;

ARCHITECTURE sol OF controlador IS
Type estado is (Ta,Tb,Tc,Td,Te,Tf,Tg,Th,Ti,Tj,Tk,Tl,Tm,T0,Tx1,
					Tra,Trb,Trc,Trd,Tre,Trf,
					Taa,Tab,Tac,Tad,Tae,Taf,Tag,Tah,
					Tda,Tdb,Tdc,Tdd,Tde,Tdf,Tdg,Tdh,Tdi,
					Tca,Tcb,Tcd,Tce,Tcf,Tci,Tch,
					Tpa,Tpb,Tpc,Tpd,Tpe,Tpg,Tph,Tpi,Tpj,Tpk,Tpl,Tpm,Tpn,Tp0,Tpp,Tpx);
SIGNAL y:estado;
BEGIN
	PROCESS(clock,reset)
	BEGIN
		if reset='0' then y<=Ta;
  		elsif (clock'event and clock='1') then
			case y is
				when Ta=> 	if start='1' then y<=Tb;
								else y<=Ta;
								end if;
				when Tb=>	if start='1' then y<=Tb;
								else y<=Tc;
								end if;
				when Tc=>	if tecla='1' then y<=Td;
								elsif borrar='1' then y<=Tra; end if;
				when Td=>	if tecla='0' then y<=Te; end if;
				when Te=>	if ID_in='1' then y<=Tf;
								else y<=Tc; end if;
				when Tf=>	if ok_ID='1' then y<=Ti;
								elsif stop_R='1' then y<=Th;
								else y<=Tg; end if;
				when Tg=>	y<=Tf;
				when Th=>	if cont_3s='1' then y<=Trc; end if;
				when Ti=>	if tecla='1' then y<=Tj;end if;
				when Tj=>	if tecla='0' then y<=Tk;end if;
				when Tk=>	if passw_in='1' then y<=Trd;
								else y<=Ti; end if;
				when Tl=>	if ok_passw='1' and ultima='1' then y<=Trf;
								elsif ok_passw='1' and ultima='0' then y<=Tx1;
								elsif stop_PS='1' then y<=Th;
								elsif stop_PS='0' then y<=Tm; end if;
				when Tx1=>	y<=Tre;
				when Tm=>	y<=Tl;
				when T0=>	if acreditar_valor='1' then y<=Taa;
								elsif debito='1' then y<=Tda;
								elsif consultar_saldo='1' then y<=Tca;
								elsif cambiar_clave='1' then y<=Tpa;
								else y<=T0; end if;
				when Tra=>	if borrar='0' then y<=Trb; end if;
				when Trb=>	y<=Tc;
				when Trc=>	y<=Tc;
				when Trd=>  y<=Tl;
				
				when Tre=>  if nxt='1' then y<=Trf;
								else y<=Th;end if;
								
				when Trf=>	y<=T0;
				when Taa=>	if acreditar_valor='0' then y<=Tab;end if;
				when Tab=>	if tecla='1' and deposito_in='1' then y<=Tab;
								elsif tecla='1' and deposito_in='0' then y<=Tac;
								elsif borrar='1' then y<=Tad;
								elsif borrar='0' and aceptar='0' then y<=Tab;
								elsif borrar='0' and aceptar='1' then y<=Taf;
								end if;
				when Tac=>	if tecla='0' then y<=Tab; end if;
				when Tad=>	if borrar='0' then y<=Tae; end if;
				when Tae=>	y<=Tab;
				when Taf=>	if aceptar='0' and deposito_OK='1' then y<=Tag;
								elsif aceptar='0' and deposito_OK='0' then y<=Th; 
								end if;
				when Tag=> y<=Tah;
				when Tah=> y<=Tc;
				when Tda=> if debito='0' then y<=Tdb; end if;
				when Tdb=>	if tecla='1' and debito_in='1' then y<=Tdb;
								elsif tecla='1' and debito_in='0' then y<=Tdc;
								elsif borrar='1' then y<=Tdd;
								elsif borrar='0' and aceptar='0' then y<=Tdb;
								elsif borrar='0' and aceptar='1' then y<=Tdf;
								end if;	
				when Tdc=>	if tecla='0' then y<=Tdb; end if;
				when Tdd=>	if borrar='0' then y<=Tde; end if;
				when Tde=>	y<=Tdb;
				when Tdf=>	if aceptar='0' then y<=Tdg; end if;
				when Tdg=>	if debito_ok='0' then y<=Th;
								elsif val_resta='0' then y<=Th;
								else y<=Tdh; end if;
				when Tdh=>	y<=Tdi;
				when Tdi=>	y<=Tc;
				when Tca=>	if consultar_saldo='0' then y<=Tcb; end if;
				when Tcb=>	if tecla='1' then y<=Tcd;end if;
				when Tcd=>	if tecla='0' then y<=Tce;end if;
				when Tce=>	if passw_in='0' then y<=Tcb;
								else y<=Tcf; end if;	
				when Tcf=>	if consulta_ok='1' then y<=Tch;
								else y<=Th; end if;
				when Tch=>	if cont_5s='1' then y<=Tci; end if;
				when Tci=>	y<=Tc;
				when Tpa=>	if cambiar_clave='0' then y<=Tpb; end if;
				when Tpb=>	if tecla='1' then y<=Tpc; end if;
				when Tpc=>	if tecla='0' then y<=Tpd; end if;
				when Tpd=>	if passw_in='0' then y<=Tpb;
								else y<=Tpe; end if;
				when Tpe=>	if consulta_OK='0' then y<=Th;
								else y<=Tpg; end if;
				when Tpg=>	y<=Tph;
				when Tph=>	if tecla='1' then y<=Tpi; end if;
				when Tpi=>	if tecla='0' then y<=Tpj; end if;
				when Tpj=>	if passw_in='0' then y<=Tph;
								else y<=Tpk; end if;
				when Tpk=>	if consulta_ok='1' then y<=Th;
								elsif consulta_OK='0' and stop_PS='0' then y<=TPl;
								elsif consulta_OK='0' and stop_PS='1' then y<=Tpm; 
								end if;
				when Tpl=>	y<=Tpk;
				when Tpm=>	if ultima='1' then y<=Tpn;
								else y<=Tpx;end if;
				when Tpn=>	y<=Tp0;
				when Tp0=>	if cont_3s='1' then y<=Tpp; end if;
				when Tpp=>	y<=Tc;
				when Tpx=>	y<=Tpn;
			end case;
		end if;
	END PROCESS;
	
PROCESS(y,start,tecla,passw_in,ID_in,deposito_in,debito_in,acreditar_valor,
			debito,consultar_saldo,cambiar_clave,aceptar,borrar,ok_ID,ok_passw,
			stop_R,deposito_OK,debito_OK,val_resta,consulta_OK,cont_3s,cont_5s,
			ultima,stop_PS,nxt)
	BEGIN
		error<='0';verde<='0';enRegA<='0';resetRA<='0';enDT<='0';resetD<='0';enRegB<='0';resetRB<='0';
		  w_saldo<='0';w_passw<='0';enAdd<='0';resetAdd<='0';endeco<='0';select_DP<='0';
		  select_mux<='0';enRegC<='0';resetDP<='0';enT<='0';resetT<='0';resetPS<='0';resetOC<='0';ldPS<='0';
		  enOC<='0';enPS<='0';selPS<='0';selN<='0';ingre_ID<='0'; ingre_PASS<='0'; elig_OP<='0'; inicio<='0';ensald<='0';rsald<='0';
			case y is
				when Ta=> 	resetOC<='1';resetD<='1';resetDP<='1';inicio<='1';
				when Tb=>	resetRA<='1';resetRB<='1';resetPS<='1';resetAdd<='1';rsald<='1';
				when Tc=>	if tecla='1' then enRegA<='1'; end if;ingre_ID<='1';
				when Td=>	
				when Te=>	enDT<='1';
				when Tf=>	if ok_ID='1' then resetD<='1'; end if;
				when Tg=>	enAdd<='1';
				when Th=>	error<='1';enT<='1';
				when Ti=>	if tecla='1' then enRegB<='1'; end if;ingre_PASS<='1';
				when Tj=>	
				when Tk=>	enDT<='1'; 
				when Tl=>	
				when Tm=>	enPS<='1';
				when T0=>	resetD<='1';elig_OP<='1';
				when Tx1=>	
				when Tra=>	
				when Trb=>	resetD<='1';resetRA<='1';
				when Trc=>	resetT<='1';resetRA<='1';resetRB<='1';resetAdd<='1';
								resetD<='1';resetDP<='1';resetPS<='1';resetOC<='1';rsald<='1';
				when Trd=>  enPS<='1';ldPS<='1';
				when Tre=>	selN<='1';
				when Trf=>	enOC<='1';ensald<='1';
				when Taa=>	
				when Tab=>	if tecla='1' and deposito_in='0' then enRegC<='1';end if;
				when Tac=>	if tecla='0' then enDT<='1'; end if;
				when Tad=>	
				when Tae=>	resetDP<='1';resetD<='1';
				when Taf=>	
				when Tag=>	w_saldo<='1';
				when Tah=>	resetRA<='1';resetRB<='1';resetAdd<='1';resetD<='1';resetDP<='1';
								resetPS<='1';resetOC<='1';rsald<='1';
				when Tda=>	
				when Tdb=>	if tecla='1' and debito_in='0' then enRegc<='1'; end if;
				when Tdc=>	if tecla='0' then enDT<='1'; end if;
				when Tdd=>	
				when Tde=>	resetDP<='1';resetD<='1';
				when Tdf=>
				when Tdg=>
				when Tdh=>	select_mux<='1';w_saldo<='1';
				when Tdi=>	resetRA<='1';resetRB<='1';resetAdd<='1';
								resetD<='1';resetDP<='1';resetPS<='1';resetOC<='1';rsald<='1';
				when Tca=>	
				when Tcb=>	endeco<='1';if tecla='1' then enRegC<='1'; end if;
				when Tcd=>	endeco<='1';
				when Tce=>	endeco<='1';enDT<='1';
				when Tcf=>	endeco<='1';
				when Tci=>	resetT<='1';resetRA<='1';resetRB<='1';resetAdd<='1';
								resetD<='1';resetDP<='1';resetPS<='1';resetOC<='1';rsald<='1';
				when Tch=>	enT<='1';select_DP<='1';
				when Tpa=>
				when Tpb=>	if tecla='1' then enRegC<='1'; end if;
				when Tpc=>	
				when Tpd=>	enDT<='1';
				when Tpe=>
				when Tpg=>	resetDP<='1';resetD<='1';ldPS<='1';enPS<='1';
				when Tph=>	if tecla='1' then enRegC<='1'; end if;
				when Tpi=>	
				when Tpj=>	enDT<='1';
				when Tpk=>	
				when Tpl=>	enPS<='1';
				when Tpm=>	selPS<='1';ldPS<='1'; enPS<='1';
				when Tpn=>	w_passw<='1';
				when Tp0=>	enT<='1'; verde<='1';
				when Tpp=>	resetT<='1';resetRA<='1';resetRB<='1';resetAdd<='1';
								resetD<='1';resetDP<='1';resetPS<='1';resetOC<='1';rsald<='1';
				when Tpx=>	enPS<='1';
			end case;
	END PROCESS;
END sol;

