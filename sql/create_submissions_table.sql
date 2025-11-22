-- SQL pour créer la table `submissions` dans Supabase (Postgres)
-- Exécutez via SQL editor Supabase

-- Activer l'extension pour UUID (si nécessaire)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS public.submissions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  text text NOT NULL,
  words integer,
  source text,
  consent boolean DEFAULT true,
  status text DEFAULT 'pending',
  note text,
  submitted_at timestamptz DEFAULT now()
);

-- Index utiles
CREATE INDEX IF NOT EXISTS submissions_submitted_at_idx ON public.submissions (submitted_at DESC);
CREATE INDEX IF NOT EXISTS submissions_status_idx ON public.submissions (status);
