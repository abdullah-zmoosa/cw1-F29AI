% Define basic types for the monsters
basicType(ghost).
basicType(psychic).
basicType(fighting).
basicType(normal).
basicType(dark).

% Define the monsters and their move types
monster(annihilape, ghost).
monster(espathra, psychic).
monster(flamigo, fighting).
monster(lechonk, normal).
monster(mabosstiff, dark).

% Define the monster moves and their move types
move(lowKick, fighting).
move(shadowPunch, ghost).
move(rageFist, ghost).
move(bodySlam, normal).

move(psybeam, psychic).
move(quickAttack, normal).
move(shadowBall, ghost).
move(payback, dark).

move(megaKick, normal).
move(closeCombat, fighting).
move(tackle, normal).
move(takeDown, normal).

move(zenHeadbutt, psychic).
move(snarl, dark).
move(lick, ghost).
move(bite, dark).

% Define the monsters moves
monsterMove(annihilape, lowKick).
monsterMove(annihilape, shadowPunch).
monsterMove(annihilape, rageFist).
monsterMove(annihilape, bodySlam).

monsterMove(espathra, psybeam).
monsterMove(espathra, quickAttack).
monsterMove(espathra, lowKick).
monsterMove(espathra, shadowBall).

monsterMove(flamigo, lowKick).
monsterMove(flamigo, payback).
monsterMove(flamigo, megaKick).
monsterMove(flamigo, closeCombat).

monsterMove(lechonk, tackle).
monsterMove(lechonk, takeDown).
monsterMove(lechonk, zenHeadbutt).
monsterMove(lechonk, bodySlam).

monsterMove(mabosstiff, snarl).
monsterMove(mabosstiff, lick).
monsterMove(mabosstiff, bite).
monsterMove(mabosstiff, bodySlam).

% Define the effectiveness between monster types
typeEffectiveness(weak, psychic, psychic).
typeEffectiveness(strong, psychic, fighting).
typeEffectiveness(superweak, psychic, dark).
typeEffectiveness(ordinary, psychic, ghost).
typeEffectiveness(ordinary, psychic, normal).

typeEffectiveness(weak, fighting, psychic).
typeEffectiveness(ordinary, fighting, fighting).
typeEffectiveness(strong, fighting, dark).
typeEffectiveness(superweak, fighting, ghost).
typeEffectiveness(strong, fighting, normal).

typeEffectiveness(strong,dark, psychic).
typeEffectiveness(weak,dark, fighting).
typeEffectiveness(weak,dark, dark).
typeEffectiveness(strong,dark, ghost).
typeEffectiveness(ordinary,dark, normal).

typeEffectiveness(strong, ghost, psychic).
typeEffectiveness(ordinary, ghost, fighting).
typeEffectiveness(weak, ghost, dark).
typeEffectiveness(strong, ghost, ghost).
typeEffectiveness(superweak, ghost, normal).

typeEffectiveness(ordinary, normal, psychic).
typeEffectiveness(ordinary, normal, fighting).
typeEffectiveness(ordinary, normal, dark).
typeEffectiveness(superweak, normal, ghost).
typeEffectiveness(ordinary, normal, normal).

% Define the hierarchy for effectiveness
moreEffective(strong, ordinary).
moreEffective(ordinary, weak).
moreEffective(weak, superweak).


% The Rule to determine transitive effectiveness
moreEffectiveThan(E1, E2) :-
    moreEffective(E1, E2).

moreEffectiveThan(E1, E2) :-
    moreEffective(E1, E), moreEffectiveThan(E, E2).

% Defining the rules needed to match monsters with the same monster moves
monsterMoveMatch(T, MO1, MO2, MV) :-
    basicType(T),monsterMove(MO1,MV),monsterMove(MO2, MV),move(MV,T).
% Defining the rules needed to determine which monster moves are more effective than the other for a specific monster type.
moreEffectiveMoveType(MV1, MV2, T) :-
    basicType(MType1),basicType(MType2),basicType(T), move(MV1, MType1),move(MV2, MType2),typeEffectiveness(E1, MType1, T),typeEffectiveness(E2, MType2, T), moreEffectiveThan(E1, E2). 
% Defining the rules needed to determine which monster and monster move is effective against another monster using a different monster move.
moreEffectiveMove(MO1, MV1, MO2, MV2) :-
    basicType(MType1),basicType(MType2),basicType(MType3),basicType(MType4),monsterMove(MO1, MV1),monsterMove(MO2, MV2),monster(MO1, MType1),monster(MO2, MType2),move(MV1, MType3),move(MV2, MType4),typeEffectiveness(E1, MType3, MType2),typeEffectiveness(E2, MType4, MType1),moreEffectiveThan(E1, E2).