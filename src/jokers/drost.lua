SMODS.Joker{
    key='drost',
    atlas = 'placeholders',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            x_mult = 1,
            numerator = 3, --todo make this compatible with oops all 6s
            denominator = 3,
        }
    },
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult, --current x_mult
                card.ability.extra.x_mult + 1, --x_mult of next Joker
                card.ability.extra.numerator,
                card.ability.extra.denominator,
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
            local new_card = SMODS.create_card(
                    {
                        set = "Joker",
                        area = G.jokers,
                        key = "j_drost_drost",
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
            new_card.ability.extra.denominator = card.ability.extra.denominator + 1
            new_card.ability.extra.x_mult = card.ability.extra.x_mult + 1

            new_card:add_to_deck()
            G.jokers:emplace(new_card)

            return {
                message = "Bye bye"
            }
        end
    end

}