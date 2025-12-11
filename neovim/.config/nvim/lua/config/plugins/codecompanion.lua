return {
  --[[
  'olimorris/codecompanion.nvim',
  config = function()
    require('codecompanion').setup {
      prompt_library = {
        ['Code Expert'] = {
          strategy = 'chat',
          description = 'Get some special advice from an LLM',
          opts = {
            short_name = 'expert',
            auto_submit = true,
            stop_context_insertion = true,
            user_prompt = true,
          },
          prompts = {
            {
              role = 'system',
              content = function(context)
                return 'I want you to act as a senior '
                  .. context.filetype
                  .. ' developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples.'
              end,
            },
            {
              role = 'user',
              content = function(context)
                local text = require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)

                return 'I have the following code:\n\n```' .. context.filetype .. '\n' .. text .. '\n```\n\n'
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
      },
      adapters = {
        mistral = function()
          return require('codecompanion.adapters').extend('mistral', {
            env = {
              api_key = 'changeme',
              url = 'https://codestral.mistral.ai',
            },
            schema = {
              model = {
                default = 'codestral-latest',
              },
              temperature = {
                default = 0.7,
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = 'mistral',
        },
        inline = {
          adapter = 'mistral',
          keymaps = {
            accept_change = {
              modes = { n = '<leader>ca' },
              description = '[c]ode - [a]ccept AI change',
            },
            reject_change = {
              modes = { n = '<leader>cr' },
              description = '[c]ode - [r]eject AI change',
            },
          },
        },
      },
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  ]]
  --
}
