/*Source code of expert system*/
main:-
diagnostico(Resultado),
write('El diagnostico para el paciente es: '),
write(Resultado),
nl,
write('LAVESE LOS DIENTES'),
undo.

/*Hypothesis that should be tested*/
diagnostico(fractura_horizontal_con_pulpa_implicada) :- fractura_horizontal_con_pulpa_implicada, !.
diagnostico(fractura_horizontal_sin_pulpa_implicada) :- fractura_horizontal_sin_pulpa_implicada, !.
diagnostico(fractura_oblicua_con_pulpa_implicada) :- fractura_oblicua_con_pulpa_implicada, !.
diagnostico(fractura_oblicua_sin_pulpa_implicada) :- fractura_oblicua_sin_pulpa_implicada, !.
diagnostico(la_pulpa_esta_muerta) :- la_pulpa_esta_muerta, !.
diagnostico(pulpa_daniada_y_viva_de_manera_irreversible) :- pulpa_daniada_y_viva_de_manera_irreversible, !.
diagnostico(pulpa_daniada_y_viva_de_manera_reversible) :- pulpa_daniada_y_viva_de_manera_reversible, !.
diagnostico(periodontitis) :- periodontitis, !.
diagnostico(diagnostico_desconocido).

/*Hypothesis Identification Rules*/
fractura_horizontal_con_pulpa_implicada :-
verificar(diente_fisurado),
verificar(diente_fracturado_horizontalmente),
verificar(pulpa_expuesta),
write('Sugerencias para diagnostico:'),
nl,
write('Duerma 8 horas'),
nl.

fractura_horizontal_sin_pulpa_implicada :-
verificar(diente_fisurado),
verificar(diente_fracturado_horizontalmente),
not(verificar(pulpa_expuesta)),
write('Sugerencias para diagnostico:'),
nl,
write('Duerma 8 horas'),
nl.

fractura_oblicua_con_pulpa_implicada :-
verificar(diente_fisurado),
not(verificar(diente_fracturado_horizontalmente)),
verificar(pulpa_fracturada_oblicuamente),
verificar(pulpa_expuesta),
write('Sugerencias para diagnostico:'),
nl,
write('Duerma 8 horas'),
nl.

fractura_oblicua_sin_pulpa_implicada :-
verificar(diente_fisurado),
not(verificar(diente_fracturado_horizontalmente)),
verificar(pulpa_fracturada_oblicuamente),
not(verificar(pulpa_expuesta)),
write('Sugerencias para diagnostico:'),
nl,
write('Duerma 8 horas'),
nl.

la_pulpa_esta_muerta :-
not(verificar(diente_fisurado)),
verificar(diente_con_caries_grandes),
verificar(dolor_agudo_por_7_dias),
write('Requiere una Endodoncia!'),
nl,
verificar(dolor_a_la_percusion_vertical),
verificar(dolor_a_la_percusion_horizontal),
verificar(dolor_a_la_palpacion_apical),
not(verificar(dolor_al_poner_aire_frio_al_diente)),
write('Sugerencias para diagnostico:'),
nl,
write('Duerma 8 horas'),
nl.

pulpa_daniada_y_viva_de_manera_irreversible :-
not(verificar(diente_fisurado)),
verificar(diente_con_caries_grandes),
verificar(dolor_agudo_por_7_dias),
write('Requiere una Endodoncia!'),
nl,
not(verificar(dolor_a_la_percusion_vertical)),
verificar(dolor_a_la_percusion_horizontal),
not(verificar(dolor_a_la_palpacion_apical)),
verificar(dolor_al_poner_aire_frio_al_diente),
write('Sugerencias para diagnostico:'),
nl,
write('Duerma 8 horas'),
nl.

pulpa_daniada_y_viva_de_manera_reversible :-
not(verificar(diente_fisurado)),
verificar(diente_con_caries_grandes),
verificar(dolor_agudo_por_7_dias),
write('Requiere una Endodoncia!'),
nl,
not(verificar(dolor_a_la_percusion_vertical)),
not(verificar(dolor_a_la_percusion_horizontal)),
not(verificar(dolor_a_la_palpacion_apical)),
verificar(dolor_al_poner_aire_frio_al_diente),
write('Sugerencias para diagnostico:'),
nl,
write('Duerma 8 horas'),
nl.

periodontitis :-
not(verificar(diente_fisurado)),
not(verificar(diente_con_caries_grandes)),
not(verificar(encia_irritada)),
not(verificar(dolor_a_la_palpacion_apical)),
verificar(el_diente_se_mueve),
not(verificar(dolor_al_poner_aire_frio_al_diente)),
verificar(se_observa_perdida_de_masa_en_el_diente),
write('Sugerencias para diagnostico:'),
nl,
write('Duerma 8 horas'),
nl.


/* how to ask questions */
ask(Question) :-
write('El odontologo ve el siguiente sintoma: '),
write(Question),
write('? '),
read(Response),
nl,
( (Response == si ; Response == s)
->
assert(si(Question)) ;
assert(no(Question)), fail).

:- dynamic si/1,no/1.
/*How to verify something */
verificar(S) :-
(si(S)
->
true ;
(no(S)
->
fail ;
ask(S))).
/* undo all yes/no assertions*/
undo :- retract(si(_)),fail.
undo :- retract(no(_)),fail.
undo.