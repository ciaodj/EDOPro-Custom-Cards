local s,id=GetID()
function s.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetDescription(aux.Stringid(12345678,0))
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
  e1:SetCode(EVENT_SUMMON_SUCCESS)
  e1:SetTarget(s.sptg)
  e1:SetOperation(s.spop)
  c:RegisterEffect(e1)
end

function s.filter(c,e,tp)
  return c:IsSetCard(0x1068) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
    and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_HAND,0,2,nil,e,tp) end
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND)
  Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end

function s.spop(e,tp,eg,ep,ev,re,r,rp)
  if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
  local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_HAND,0,2,2,nil,e,tp)
  if g:GetCount()==2 then
    Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
    Duel.Draw(tp,1,REASON_EFFECT)
  end
end
