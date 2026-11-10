create table if not exists public.project_snapshots (
  id text primary key,
  owner_id uuid not null default auth.uid(),
  payload jsonb not null,
  is_public boolean not null default true,
  updated_at timestamptz not null default now()
);

alter table public.project_snapshots enable row level security;

drop policy if exists "Public can read project snapshots" on public.project_snapshots;
create policy "Public can read project snapshots"
on public.project_snapshots for select
using (is_public = true);

drop policy if exists "Owners can insert project snapshots" on public.project_snapshots;
create policy "Owners can insert project snapshots"
on public.project_snapshots for insert
to authenticated
with check (auth.uid() = owner_id);

drop policy if exists "Owners can update project snapshots" on public.project_snapshots;
create policy "Owners can update project snapshots"
on public.project_snapshots for update
to authenticated
using (auth.uid() = owner_id)
with check (auth.uid() = owner_id);

drop policy if exists "Owners can delete project snapshots" on public.project_snapshots;
create policy "Owners can delete project snapshots"
on public.project_snapshots for delete
to authenticated
using (auth.uid() = owner_id);

do $$
begin
  if exists (select 1 from pg_publication where pubname = 'supabase_realtime')
  and not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'project_snapshots'
  ) then
    alter publication supabase_realtime add table public.project_snapshots;
  end if;
end
$$;
