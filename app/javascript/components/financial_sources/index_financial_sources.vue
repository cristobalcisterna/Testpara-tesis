<template>
  <section class="b-tooltips">
    <div
      class="box"
      style="margin-top: 60px; margin-left: 300px; margin-right: 300px"
    >
      <h1>Fuentes de financiamiento</h1>
      <b-tabs>


        <b-tab-item label="Fuentes de financiamiento de la facultad">
          <div class="center">
            <h1>Fuentes de financiamiento</h1>
          </div>
          <div class="has-text-right">
            <b-button
              label="Añadir Fuente de financiamiento"
              type="is-info"
              icon-left="plus"
              @click="createFinancial()"
            ></b-button>
          </div>
          <div> 
            <b-modal
              :active="isModalActive"
              aria-modal
              has-modal-card
              :destroy-on-hide="true"
              aria-role="dialog"
              width="100%"
              :can-cancel="canCancel"
            >
              <template>
                <new-financial-sources
                  modal-cancel="true"
                  :modal-header="'Registro de Fuente de financiamiento'"
                  query-type="create"
                  @close="closeModalCreate"
                ></new-financial-sources>
              </template>
            </b-modal>
          </div>
          <div class="column">
            <b-table
              id="table"
              :data="financial_sources"
              :paginated="true"
              per-page="8"
              striped
              hoverable
              :pagination-simple="false"
              pagination-active-color="hsl(0, 0%, 0%)"
              pagination-position="bottom"
              default-sort-direction="asc"
              sort-icon="arrow-up"
              aria-next-label="Siguiente"
              aria-previous-label="Anterior"
              aria-page-label="Página"
              aria-current-label="Página actual">
              <b-table-column
                :visible="false"
                field="id"
                label="ID"
                sortable
                searchable>
                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>
              <b-table-column
                field="name_financial_source"
                label="Nombre Fuente"
                sortable
                searchable>
                <template v-slot="props">
                <a href="#" type="is-info" @click="Clickshowfinancial(props.row.id)">{{ props.row.name_financial_source }}</a>
                </template>
              </b-table-column>


                            <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                   <b-tooltip label="Ver detalle" type="is-info">
                <b-icon pack="fas" icon="eye" size="is-medium"
              @click.native="Clickshowfinancial(props.row.id)"/>
              </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Anular" type="is-info">
                      <b-icon pack="fas" icon="trash" size="is-medium"
                        @click.native="confirmGoodNull(props.row.id)" />
                    </b-tooltip>
                  </div>
                </div>
              </b-table-column>

            </b-table>
          </div>
        </b-tab-item>


                <b-tab-item label="Fuente de financiamiento en papelera">
          <div class="center">
            <h1>Fuente de financiamiento en papelera</h1>
          </div>
          <div class="column">
            <b-table
              id="table"
              :data="null_financial_sources"
              :paginated="true"
              per-page="8"
              striped
              hoverable
              :pagination-simple="false"
              pagination-active-color="hsl(0, 0%, 0%)"
              pagination-position="bottom"
              default-sort-direction="asc"
              sort-icon="arrow-up"
              aria-next-label="Siguiente"
              aria-previous-label="Anterior"
              aria-page-label="Página"
              aria-current-label="Página actual">
              <b-table-column
                :visible="false"
                field="id"
                label="ID"
                sortable
                searchable>
                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>
              <b-table-column
                field="name_financial_source"
                label="Nombre Fuente"
                sortable
                searchable>
                <template v-slot="props">
                <a href="#" type="is-info" @click="Clickshowfinancial(props.row.id)">{{ props.row.name_financial_source }}</a>
                </template>
              </b-table-column>


                            <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                   <b-tooltip label="Ver detalle" type="is-info">
                <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowfinancial(props.row.id)"/>
              </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Restaurar" type="is-info">
                      <b-icon pack="fas" icon="trash-arrow-up" size="is-medium"
                        @click.native="confirmGoodRest(props.row.id)" />
                    </b-tooltip>
                  </div>
                </div>
              </b-table-column>

            </b-table>
          </div>
        </b-tab-item>



      </b-tabs>
    </div>
  </section>
</template>


<script>
import axios from "axios";
import NewFinancialSources from "./new_financial_sources.vue";
import ShowFinancialSources from "./show_financial_sources.vue";
export default {
  data() {
    return {
      financial_sources: [],
      null_financial_sources: [],
      canCancel: ["escape"],
      isModalActive: false,
      isModalActiveShow: false,
      selected: null,
      null_active: 0,
      des_active: 1,
    };
  },
  components: {
    NewFinancialSources,
    ShowFinancialSources,
  },
  props: ["financial_sourceId"],
  methods: {

    async get_financial_sources_active() {
      const response = await axios.get("/financial_sources/showactivefinancial_source.json");
      this.financial_sources = response.data;
    },

        async null_get_financial_sources() {
      const response = await axios.get("/financial_sources/shownullfinancial_source.json");
      this.null_financial_sources = response.data;
    },

     async AnulClick(item) {
      const response = await axios.put("/financial_sources/" + item + ".json", {
        active_financial_source: this.null_active,
      });
      window.location.href = "/financial_sources";
    },

    async RestClick(item) {
      const response = await axios.put("/financial_sources/" + item + ".json", {
        active_financial_source: this.des_active,
      });
      window.location.href = "/financial_sources";
    },
    confirmGoodRest(item) {
      this.$buefy.dialog.confirm({
        title: "Restaurar Fuente de financiamiento",
        message: "¿Esta seguro de querer restaurar la Fuente de financiamiento?.",
        confirmText: "Restaurar",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.RestClick(item),
      });
    },

    confirmGoodNull(item) {
      this.$buefy.dialog.confirm({
        title: "Anular Fuente de financiamiento",
        message: "¿Esta seguro de querer anular la Fuente de financiamiento?.",
        confirmText: "Anular",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.AnulClick(item),
      });
    },





    async Clicknewfinancial() {
      const response = (window.location.href = "/financial_sources/new");
    },
    async Clickshowfinancial(item) {
      const response = (window.location.href = "/financial_sources/" + item);
      console.log(this.item);
    },
    async createFinancial() {
      this.isModalActive = true;
    },
    async closeModalCreate() {
      this.isModalActive = false;
    },
    async ShowModaleUnit(item) {
      this.selected = item;
      this.isModalActiveShow = true;
    },
    async closeModalShow() {
      this.isModalActiveShow = false;
    },
  },
  created() {
    this.get_financial_sources_active();
    this.null_get_financial_sources();
  },
};
</script>


