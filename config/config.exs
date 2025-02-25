import Config

config :n2o,
  protocols: [:nitro_n2o],
  routes: Chat.Routes,
  pickler: :n2o_secret,
  mq: :n2o_syn,
  app: :chat,
  static: "priv/static",
  port: 8000
