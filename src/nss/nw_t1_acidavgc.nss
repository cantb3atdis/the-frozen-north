//::///////////////////////////////////////////////
//:: Average Acid Blob
//:: NW_T1_AcidAvgC
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target is hit with a blob of acid that does
    5d6 Damage and holds the target for 3 rounds.
    Can make a Reflex save to avoid the hold effect.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 4th, 2001
//:://////////////////////////////////////////////
#include "nw_i0_spells"

void main()
{
    //1.72: fix for bug where traps are being triggered where they really aren't
    if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_TRIGGER && !GetIsInSubArea(GetEnteringObject()))
    {
        return;
    }
    //Declare major variables
    int nDuration = 3;
    object oTarget = GetEnteringObject();
    effect eDam = EffectDamage(d6(5), DAMAGE_TYPE_ACID);
    effect eHold = EffectParalyze();
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    effect eDur = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eLink = EffectLinkEffects(eHold, eDur);
    int nDamage;

    //Make Reflex Save
    if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, 20, SAVING_THROW_TYPE_TRAP))
    {
        //Apply Hold and Damage
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    }
    else
    {
        //Apply Damage
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}

