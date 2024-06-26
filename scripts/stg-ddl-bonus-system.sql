drop table if exists stg.bonussystem_users;
create table stg.bonussystem_users(
	id int4 NOT NULL,
	order_user_id text NOT null,
	CONSTRAINT bonussystem_users_pkey PRIMARY KEY (id)
);

drop table if exists stg.bonussystem_ranks;
create table stg.bonussystem_ranks(
	id int4 NOT NULL,
	"name" varchar(2048) NOT NULL,
	bonus_percent numeric(19, 5) DEFAULT 0 NOT NULL,
	min_payment_threshold numeric(19, 5) DEFAULT 0 NOT NULL,
	CONSTRAINT ranks_bonus_percent_check CHECK ((bonus_percent >= (0)::numeric)),
	CONSTRAINT ranks_bonus_percent_check1 CHECK ((bonus_percent >= (0)::numeric)),
	CONSTRAINT ranks_pkey PRIMARY KEY (id)
);

drop table if exists stg.bonussystem_events;
create table stg.bonussystem_events(
	id int4 NOT NULL,
	event_ts timestamp NOT NULL,
	event_type varchar NOT NULL,
	event_value text NOT NULL,
	CONSTRAINT outbox_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_bonussystem_events__event_ts ON stg.bonussystem_events USING btree (event_ts);