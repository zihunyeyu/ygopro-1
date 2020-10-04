--高速决斗技能-反转痛苦
Duel.LoadScript("speed_duel_common.lua")
function c100730044.initial_effect(c)
	aux.SpeedDuelAtMainPhaseNoCountLimit(c,c100730044.skill,c100730044.con,aux.Stringid(100730044,0))
	aux.RegisterSpeedDuelSkillCardCommon()
	if not c100730044.battle_damage then
		c100730044.battle_damage={}
		c100730044.battle_damage[0]=0
		c100730044.battle_damage[1]=0
		c100730044.battle_damage[2]=0
		c100730044.battle_damage[3]=0
	end
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetOperation(c100730044.damcal)
	Duel.RegisterEffect(e1,0)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetOperation(c100730044.damcalreset)
	Duel.RegisterEffect(e1,0)
end

function c100730044.damcal(e,tp,eg,ep,ev,re,r,rp)
	c100730044.battle_damage[ep]=c100730044.battle_damage[ep]+ev
end

function c100730044.damcalreset(e,tp,eg,ep,ev,re,r,rp)
	c100730044.battle_damage[2]=c100730044.battle_damage[0]
	c100730044.battle_damage[3]=c100730044.battle_damage[1]
	c100730044.battle_damage[0]=0
	c100730044.battle_damage[1]=0
end

function c100730044.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and c100730044.battle_damage[tp+2]>0
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
end

function c100730044.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_SELECTMSG,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	if not g or g:GetCount()==0 then return end
	local fc=g:GetFirst()
	local e1=Effect.CreateEffect(fc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(math.floor(c100730044.battle_damage[tp+2]/2))
	fc:RegisterEffect(e1)
end