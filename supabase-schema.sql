create table if not exists public.trainers (
  id text primary key,
  board text not null check (board in ('teaching', 'operations')),
  name text not null,
  dept text not null,
  subject text not null,
  photo_url text not null,
  intro text not null,
  sort_order integer not null default 0,
  active boolean not null default true,
  updated_at timestamptz not null default now()
);

create table if not exists public.topics (
  id text primary key,
  trainer_id text not null references public.trainers(id) on delete cascade,
  title text not null,
  audience text not null,
  duration text not null,
  description text not null,
  sort_order integer not null default 0,
  active boolean not null default true,
  updated_at timestamptz not null default now()
);

create table if not exists public.invite_requests (
  id uuid primary key default gen_random_uuid(),
  board text not null check (board in ('teaching', 'operations')),
  trainer_id text references public.trainers(id),
  trainer_name text not null,
  trainer_dept text not null,
  trainer_subject text,
  topic_title text not null,
  requester text not null,
  requester_dept text not null,
  expected_time text,
  training_format text,
  training_audience text,
  expected_count text,
  note text,
  status text not null default '待人力确认',
  status_updated_at timestamptz not null default now(),
  hr_note text,
  approver text,
  approval_note text,
  approved_at timestamptz,
  score_generated_at timestamptz,
  score_detail_id text,
  created_at timestamptz not null default now()
);

alter table public.invite_requests add column if not exists trainer_subject text;
alter table public.invite_requests add column if not exists training_audience text;
alter table public.invite_requests add column if not exists expected_count text;
alter table public.invite_requests add column if not exists status_updated_at timestamptz not null default now();
alter table public.invite_requests add column if not exists hr_note text;
alter table public.invite_requests add column if not exists score_generated_at timestamptz;
alter table public.invite_requests add column if not exists score_detail_id text;
alter table public.invite_requests alter column status set default '待人力确认';
update public.invite_requests
set status = '待人力确认'
where status = '待确认';

create table if not exists public.score_states (
  id text primary key,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.trainers enable row level security;
alter table public.topics enable row level security;
alter table public.invite_requests enable row level security;
alter table public.score_states enable row level security;

drop policy if exists "public can read active trainers" on public.trainers;
create policy "public can read active trainers"
on public.trainers for select
using (active = true);

drop policy if exists "authenticated can manage trainers" on public.trainers;
create policy "authenticated can manage trainers"
on public.trainers for all
to authenticated
using (true)
with check (true);

drop policy if exists "public can read active topics" on public.topics;
create policy "public can read active topics"
on public.topics for select
using (
  active = true
  and exists (
    select 1 from public.trainers
    where trainers.id = topics.trainer_id
      and trainers.active = true
  )
);

drop policy if exists "authenticated can manage topics" on public.topics;
create policy "authenticated can manage topics"
on public.topics for all
to authenticated
using (true)
with check (true);

drop policy if exists "public can create invite requests" on public.invite_requests;
create policy "public can create invite requests"
on public.invite_requests for insert
with check (true);

drop policy if exists "authenticated can read invite requests" on public.invite_requests;
create policy "authenticated can read invite requests"
on public.invite_requests for select
to authenticated
using (true);

drop policy if exists "authenticated can update invite requests" on public.invite_requests;
create policy "authenticated can update invite requests"
on public.invite_requests for update
to authenticated
using (true)
with check (true);

drop policy if exists "public can read score states" on public.score_states;
create policy "public can read score states"
on public.score_states for select
using (true);

drop policy if exists "authenticated can manage score states" on public.score_states;
create policy "authenticated can manage score states"
on public.score_states for all
to authenticated
using (true)
with check (true);

insert into storage.buckets (id, name, public)
values ('trainer-photos', 'trainer-photos', true)
on conflict (id) do update set public = true;

drop policy if exists "public can read trainer photos" on storage.objects;
create policy "public can read trainer photos"
on storage.objects for select
using (bucket_id = 'trainer-photos');

drop policy if exists "authenticated can upload trainer photos" on storage.objects;
create policy "authenticated can upload trainer photos"
on storage.objects for insert
to authenticated
with check (bucket_id = 'trainer-photos');

drop policy if exists "authenticated can update trainer photos" on storage.objects;
create policy "authenticated can update trainer photos"
on storage.objects for update
to authenticated
using (bucket_id = 'trainer-photos')
with check (bucket_id = 'trainer-photos');
