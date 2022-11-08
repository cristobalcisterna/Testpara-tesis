<template>
    <section class="b-tooltips">
      <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px">
        <h1>Bienes a cargo</h1>
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
         <!--
            <div class="has-text-right" style="margin-top: 20px; margin-left: 3px; margin-right: 3px">
              <b-button label="Añadir Bien" type="is-info" icon-left="plus" @click="createGood()"></b-button>
            </div>
  -->
  
  
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
                   {{props.row.duty_manager.name_duty_manager}}
  
  
  
                  </template>
                </b-table-column>
                <b-table-column field="office.name_building" label="Edificio" sortable searchable>
  
                  <template v-slot="props">
                    {{ props.row.office.name_building}}
  
                  </template>
                </b-table-column>
  
                <b-table-column field="office.name_office" label="Dependencia" sortable searchable>
  
                  <template v-slot="props">
                   {{ props.row.office.name_office }}
  
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
                      <b-tooltip label="Añadir estado" type="is-info">
                        <b-icon pack="fas" icon="bullhorn" size="is-medium"
                          @click.native="createConditionGood(props.row.id)" />
                      </b-tooltip>
                    </div>
                  </div>
                </b-table-column>
  
              </b-table>
            </div>

      </div>
    </section>
  </template>
  
  <script>
  import axios from "axios";
  import NewGood from "../good/new_good.vue";
  import EditGood from "../good/edit_good.vue";
  import ShowMyGood from "../good/show_my_good.vue";
  import NewConditionGood from "../condition_good/new_condition_good.vue";
  
  export default {
    data() {
      return {
        goods: [],
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
        usuario_actual:[],
        current: null,
      };
    },
    props: ["id", 'queryType', 'modalHeader', 'goodId'],
  
    components: {
      NewGood,
      EditGood,
      ShowMyGood,
      NewConditionGood,
    },
    methods: {


      async get_user_actual() {
        const response = await axios.get("/duty_managers/currentuser.json");
        this.current = response.data.current_user;
        this.getgoodsactive(this.current);
      },


      async getgoodsactive(item) {
        const response = await axios.get("/goods/showgooduser/"+ item +".json");
        this.goods = response.data;
        console.log(this.current);
        console.log(this.goods);
        
      },
  
  
      async Clicknewgood() {
        const response = (window.location.href = "/goods/new");
      },
      async Clickshowgood(item) {
        const response = (window.location.href = "/goods/mygood/" + item);
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
      this.get_user_actual();
    },
  };
  </script>
  