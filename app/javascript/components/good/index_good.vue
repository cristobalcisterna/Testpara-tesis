<template>
  <section class="b-tooltips">
    <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px">
      <h1>Bienes de la facultad</h1>

      <b-tabs type="is-boxed" position="is-centered">

        <b-tab-item label="Bienes Activos">
          <div>
            <b-modal :active="isModalActive" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <new-good modal-cancel="true" :modal-header="'Registro de Bien'" query-type="create"
                  @close="closeModalCreate"></new-good>
              </template>
            </b-modal>

            <b-modal :active="isModalActiveEdit" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <edit-good :good-id="goodId" :id="selected" :modal-header="'Editar Bien'" query-type="update"
                  @close="closeModalEdit"></edit-good>
              </template>
            </b-modal>

            <b-modal :active="isModalnewstatus" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <new-condition-good :good-id="goodId" :id="selected" :modal-header="'Reportar Bien'" query-type="create"
                  @close="closeModalCreateStatus"></new-condition-good>
              </template>
            </b-modal>
          </div>

          <div class="has-text-right" style="margin-top: 20px; margin-left: 3px; margin-right: 3px">
            <b-button label="Añadir Bien" type="is-info" icon-left="plus" @click="createGood()"></b-button>
          </div>

          <div class="center">
            <h1>Bienes Activos</h1>
          </div>

          <div class="column">
            <b-table :data="goods" striped hoverable :paginated="true" per-page="8" :pagination-simple="false"
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up">
              <b-table-column :visible="false" field="id" label="ID" sortable searchable>
                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>

              <b-table-column field="namegood" label="Nombre" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="Clickshowgood(props.row.id)">{{ props.row.namegood }}</a>
                </template>

              </b-table-column>
              <b-table-column field="identification_number_good" label="N° Inventario" sortable searchable>

                <template v-slot="props">
                  {{ props.row.identification_number_good }}
                </template>
              </b-table-column>

              <b-table-column field="duty_manager.name_duty_manager" label="Persona encargada" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowdutymanager(props.row.duty_manager_id)">{{
                  props.row.duty_manager.name_duty_manager
                  }}</a>



                </template>
              </b-table-column>
              <b-table-column field="office.name_building" label="Edificio" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowbuilding(props.row.office.building_id)">{{ props.row.office.name_building
                  }}</a>

                </template>
              </b-table-column>

              <b-table-column field="office.name_office" label="Dependencia" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowoffice(props.row.office_id)">{{ props.row.office.name_office }}</a>

                </template>
              </b-table-column>

              <b-table-column field="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                    <b-tooltip label="Ver detalle" type="is-info">
                      <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowgood(props.row.id)" />
                    </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Anular" type="is-info">
                      <b-icon pack="fas" icon="trash" size="is-medium" @click.native="confirmGoodNull(props.row.id)" />
                    </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Editar" type="is-info">
                      <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editGood(props.row.id)" />
                    </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Añadir estado" type="is-info">
                      <b-icon pack="fas" icon="bullhorn" size="is-medium"
                        @click.native="createConditionGood(props.row.id)" />
                    </b-tooltip>
                  </div>
                </div>
              </b-table-column>

            </b-table>
          </div>
        </b-tab-item>



        <b-tab-item label="Bienes en papelera">
          <div>
            <b-modal :active="isModalActive" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <new-good modal-cancel="true" :modal-header="'Registro de Bien'" query-type="create"
                  @close="closeModalCreate"></new-good>
              </template>
            </b-modal>



            <b-modal :active="isModalActiveEdit" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <edit-good :good-id="goodId" :id="selected" :modal-header="'Editar Bien'" query-type="update"
                  @close="closeModalEdit"></edit-good>
              </template>
            </b-modal>



            <b-modal :active="isModalnewstatus" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <new-condition-good :good-id="goodId" :id="selected" :modal-header="'Reportar Bien'" query-type="create"
                  @close="closeModalCreateStatus"></new-condition-good>
              </template>
            </b-modal>


          </div>
          <div class="center">
            <h1>Bienes en papelera</h1>
          </div>
          <div class="column">
            <b-table :data="null_goods" :paginated="true" per-page="8" striped hoverable :pagination-simple="false"
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up" sort-icon-size="is-small"
              type="is-info">
              <b-table-column :visible="false" field="id" label="ID" sortable searchable>
                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>
              <b-table-column field="namegood" label="Nombre" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="Clickshowgood(props.row.id)">{{ props.row.namegood }}</a>
                </template>
              </b-table-column>
              <b-table-column field="identification_number_good" label="N° Inventario" sortable searchable>
                <template v-slot="props">
                  {{ props.row.identification_number_good }}
                </template>
              </b-table-column>
              <b-table-column field="duty_manager.name_duty_manager" label="Persona encargada" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowdutymanager(props.row.duty_manager_id)">{{
                  props.row.duty_manager.name_duty_manager
                  }}</a>
                </template>
              </b-table-column>
              <b-table-column field="office.name_building" label="Edificios" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowbuilding(props.row.office.building_id)">{{ props.row.office.name_building
                  }}</a>
                </template>
              </b-table-column>
              <b-table-column field="office.name_office" label="Dependencia" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="Clickshowoffice(props.row.office_id)">{{ props.row.office.name_office }}</a>
                </template>
              </b-table-column>
              <b-table-column field="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                    <b-tooltip label="Ver detalle" type="is-info">
                      <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowgood(props.row.id)" />
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


<!--
        <b-tab-item label="Bienes pendientes">
          <div>
            <b-modal :active="isModalActive" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <new-good modal-cancel="true" :modal-header="'Registro de Bien'" query-type="create"
                  @close="closeModalCreate"></new-good>
              </template>
            </b-modal>



            <b-modal :active="isModalActiveEdit" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <edit-good :good-id="goodId" :id="selected" :modal-header="'Editar Bien'" query-type="update"
                  @close="closeModalEdit"></edit-good>
              </template>
            </b-modal>



            <b-modal :active="isModalnewstatus" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <new-condition-good :good-id="goodId" :id="selected" :modal-header="'Reportar Bien'" query-type="create"
                  @close="closeModalCreateStatus"></new-condition-good>
              </template>
            </b-modal>


          </div>
          <div class="center">
            <h1>Bienes Pendientes</h1>
          </div>
          <div class="column">
            <b-table :data="pending_goods" :paginated="true" per-page="8" striped hoverable :pagination-simple="false"
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up" sort-icon-size="is-small"
              type="is-info">
              <b-table-column :visible="false" field="id" label="ID" sortable searchable>
                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>
              <b-table-column field="namegood" label="Nombre" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="Clickshowgood(props.row.id)">{{ props.row.namegood }}</a>
                </template>
              </b-table-column>
              <b-table-column field="identification_number_good" label="N° Inventario" sortable searchable>
                <template v-slot="props">
                  {{ props.row.identification_number_good }}
                </template>
              </b-table-column>
              <b-table-column field="trademark" label="Marca" sortable searchable>
                <template v-slot="props">
                  {{ props.row.trademark }}
                </template>
              </b-table-column>
              <b-table-column field="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                    <b-tooltip label="Ver detalle" type="is-info">
                      <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowgood(props.row.id)" />
                    </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Editar" type="is-info">
                      <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editGood(props.row.id)" />
                    </b-tooltip>
                  </div>
                </div>
              </b-table-column>
            </b-table>
          </div>
        </b-tab-item>
-->

      </b-tabs>
    </div>
  </section>
</template>

<script>
import axios from "axios";
import NewGood from "./new_good.vue";
import EditGood from "./edit_good.vue";
import ShowGood from "./show_good.vue";
import NewConditionGood from "../condition_good/new_condition_good.vue";

export default {
  data() {
    return {
      goods: [],
      null_goods: [],
      pending_goods: [],
      decommissioned_goods: [],
      offices: [],
      units: [],
      managers: [],
      buildings: [],
      selected: null,
      select: null,
      canCancel: ["escape"],
      isModalActive: false,
      isModalActiveEdit: false,
      isModalActiveShow: false,
      isModalnewstatus: false,
      aux_duty_manager_id: null,
      aux_office_id: null,
      aux_unit_id: null,
      aux_building_id: null,
      null_activegood: 0,
      des_activegood: 1,
    };
  },
  props: ["id", 'queryType', 'modalHeader', 'goodId'],

  components: {
    NewGood,
    EditGood,
    ShowGood,
    NewConditionGood,
  },
  methods: {
    async getgoodsactive() {
      const response = await axios.get("/goods/showactive.json");
      this.goods = response.data;
    },

    async null_getgoods() {
      const response = await axios.get("/goods/shownull.json");
      this.null_goods = response.data;
    },

        async pending_getgoods() {
      const response = await axios.get("/goods/showgoodpending.json");
      this.pending_goods = response.data;
    },

        async decommissioned_getgoods() {
      const response = await axios.get("/goods/showgooddecommissioned.json");
      this.decommissioned_goods = response.data;
    },

    async Clicknewgood() {
      const response = (window.location.href = "/goods/new");
    },
    async Clickshowgood(item) {
      const response = (window.location.href = "/goods/" + item);
      console.log(this.item);
    },
    async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item);
    },
    async Clickshowbuilding(item) {
      const response = (window.location.href = "/buildings/" + item);
    },
    async Clickshowoffice(item) {
      const response = (window.location.href = "/offices/" + item);
    },





    

    async RestClick(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        activegood: this.des_activegood,
      });
      window.location.href = "/goods";
    },
    confirmGoodRest(item) {
      this.$buefy.dialog.confirm({
        title: "Restaurar Bien",
        message: "¿Esta seguro de querer restaurar el bien?.",
        confirmText: "Restaurar",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.RestClick(item),
      });
    },

    confirmGoodNull(item) {
      this.$buefy.dialog.confirm({
        title: "Anular Bien",
        message: "¿Esta seguro de querer anular el bien?.",
        confirmText: "Anular",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.AnulClick(item),
      });
    },

    async AnulClick(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        activegood: this.null_activegood,
      });
      window.location.href = "/goods";
    },

    async getunit() {
      const response = await axios.get("http://localhost:3000/units.json");
      this.units = response.data;
    },

    async getdutymanagerbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/duty_managers/showdutymanagerunit/" +
        item +
        ".json"
      );
      this.managers = response.data;
    },

    async getbuildingbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/buildings/showbuildingunit/" + item + ".json"
      );
      this.buildings = response.data;
    },

    async getofficebybuilding(item) {
      const response = await axios.get(
        "http://localhost:3000/offices/showofficebuilding/" + item + ".json"
      );
      this.offices = response.data;
    },
    async Clickeditgood(item) {
      const response = (window.location.href = "/goods/" + item + "/edit");
    },
    async Clickshowgood(item) {
      window.location.href = "/goods/" + item;
    },

    async createGood() {
      this.isModalActive = true;
    },
    async closeModalCreate() {
      this.isModalActive = false;
    },

    async editGood(item) {
      this.selected = item;
      this.isModalActiveEdit = true;
    },
    async closeModalEdit() {
      this.isModalActiveEdit = false;
    },
    async ShowModalGood(item) {
      this.selected = item;
      this.isModalActiveShow = true; 
    },
    async closeModalShow() {
      this.isModalActiveShow = false;
    },
        async createConditionGood(item) {
      this.selected = item;
      console.log(this.item);
      this.isModalnewstatus = true;
    },

    async closeModalCreateStatus() {
      this.isModalnewstatus = false;
    },
  },
  created() {
    this.getgoodsactive();
    this.null_getgoods();
    this.pending_getgoods();   
    this.getunit();
  },
};
</script>
