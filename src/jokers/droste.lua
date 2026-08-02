SMODS.Joker{
    key='droste',
    atlas = 'droste',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            x_mult = 1,
            odds = 1,
        }
    },
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.odds,
                card.ability.extra.x_mult, --current x_mult
                card.ability.extra.x_mult + 1, --x_mult of next Joker
            }
        }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end

        if context.selling_self then
            if pseudorandom('droste') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local new_card = SMODS.create_card(
                        {
                            set = "Joker",
                            area = G.jokers,
                            key = "j_droste_droste",
                        }
                )

                if (card.edition) then
                    new_card:set_edition(card.edition, true)
                else
                    new_card:set_edition(nil, true)
                end

                --hard code just the vanilla stickers :)
                new_card.ability.eternal = card.ability.eternal
                new_card.ability.perishable = card.ability.perishable
                new_card.ability.rental = card.ability.rental
                new_card.ability.pinned = card.ability.pinned

                --upgrade the stuff
                new_card.ability.extra.odds = card.ability.extra.odds + 0.25
                new_card.ability.extra.x_mult = card.ability.extra.x_mult + 1

                --todo figure out how to only apply this to individual joker instances rather than the base
                --calculate new sprite sheet location so he wears a different hat
                positions = {
                    { 0, 0 },
                    { 0, 1 },
                    { 0, 2 },
                    { 1, 0 },
                    { 1, 1 },
                    { 1, 2 },
                    { 2, 0 },
                    { 2, 1 },
                }

                --very likely a better way to do this but whatever
                for index, value in ipairs(positions) do
                    if self.pos.x == value[1] and self.pos.y == value[2] then
                        new_index = (index + 1) % #positions
                        if new_index == 0 then
                            new_index = 1 --thanks Lua
                        end

                        new_pos = positions[new_index]
                        self.pos.x = new_pos[1]
                        self.pos.y = new_pos[2]
                        break
                    end
                end

                new_card:add_to_deck()
                G.jokers:emplace(new_card)

                return {
                    message = "Droste!"
                }
            else
                return {
                    message = "Nope!"
                }
            end
        end
    end
}