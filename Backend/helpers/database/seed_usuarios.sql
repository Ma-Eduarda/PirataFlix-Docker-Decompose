INSERT INTO public.adm (id, nome, email, senha_hash)
VALUES (1, 'Administrador Demo', 'admin@pirataflix.com', 'scrypt:32768:8:1$lKgWdGgNupovThtP$9f0410af37811db4bfde6da7d68e014f76fc0b77f71aba5889e6835d6906dd6076f76b187743d11d30c9f1e066a7ffd300c55c09354a98c09df242744cea3ee4')
ON CONFLICT (email) DO NOTHING;

INSERT INTO public.usuario (id, nome, email, senha_hash)
VALUES (1, 'Usuario Demo', 'usuario@pirataflix.com', 'scrypt:32768:8:1$WxfJ07IxAOijuIkA$988ca3a7e3432e6cf10f22373a3d5bb185caff8755abb2820a65da8f75f0dd11f9445b19ce8b95d637a2d6b1bdac7211e7223ddb50136cbc8d5cb62eb6ca6b31')
ON CONFLICT (email) DO NOTHING;

SELECT pg_catalog.setval('public.adm_id_seq',
    COALESCE((SELECT MAX(id) FROM public.adm), 1), true);

SELECT pg_catalog.setval('public.usuario_id_seq',
    COALESCE((SELECT MAX(id) FROM public.usuario), 1), true);

-- senha: Pirataflix@123