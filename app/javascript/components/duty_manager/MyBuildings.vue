<template>
    <section class="b-tooltips">
      <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px;">
        <h1>Edificios a cargo</h1>
    
      


            <!--
            <div class="has-text-right">
                <b-button
                  label="Añadir edificio"
                  type="is-info"
                  icon-left="plus"
                  @click="createBuilding()"
                ></b-button>
              </div>
            --> 
              <div> 
                    <b-modal
            :active="isModalActive"
            aria-modal
            has-modal-card
            :destroy-on-hide="true"
            aria-role="dialog"
            width="100%"
            :can-cancel="canCancel">
          <template>
            <new-building modal-cancel="true"
                              :modal-header="'Registro de Edificio'"
                              query-type="create"
                              @close="closeModalCreate"></new-building>
          </template>
        </b-modal>
  
                   <b-modal :active="isModalActiveEdit" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
                width="100%" :can-cancel="canCancel">
                <template>
                  <edit-building :building-id="buildingId" :id="selected" :modal-header="'Editar Edificio'" query-type="update"
                    @close="closeModalEdit"></edit-building>
                </template>
              </b-modal>
  
  
  
        </div>
  
            <div class="column">
              <b-table 
              :data="buildings"
              :paginated=true 
                  per-page="8"
                  striped
                  hoverable
                  :pagination-simple=false
                  pagination-position="bottom"
                  default-sort-direction="asc" 
                  sort-icon="arrow-up"
                  sort-icon-size="is-small"
                  default-sort="inventores.name"
                  aria-next-label="Siguiente"
                  aria-previous-label="Anterior"
                  aria-page-label="Página"
                  aria-current-label="Página actual">
                <b-table-column :visible=false field="id" label="ID" sortable searchable>
  
                  <template v-slot="props">
                    {{ props.row.id }}
                  </template>
                </b-table-column>
  
                <b-table-column
                  field="name_building"
                  label="Nombre Edificio"
                  sortable
                  searchable
                >
  
                  <template v-slot="props">
                     <a href="#" @click="Clickshowbuilding(props.row.id)">{{ props.row.name_building }}</a>
  
                  </template>
                </b-table-column>
  
                <b-table-column
                  field="identification_number_building"
                  label="N° Identificación"
                  sortable
                  searchable
                >
                  <template v-slot="props">
                    {{ props.row.identification_number_building }}
                  </template>
                </b-table-column>
  
  
  
                <b-table-column
                  field="unit.name_unit"
                  label="Nombre Unidad"
                  sortable
                  searchable
                >
                  <template v-slot="props">
                  {{ props.row.unit.name_unit }}
                  </template>
                </b-table-column>
             
            <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">
                  <div class="columns">
                    <div class="column">
                     <b-tooltip label="Ver detalle" type="is-info">
                  <b-icon
                pack="fas"
                icon="eye"
                size="is-medium"
                @click.native="Clickshowbuilding(props.row.id)"/>
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
  import NewBuilding from '../building/new_building.vue';
  import ShowBuilding from '../building/show_building.vue';
  import EditBuilding from "../building/edit_building.vue";
  export default {
    data() { 
      return {
        buildings: [],
  
        offices: [],
        id_goods_list: [],
        id_offices_list: [],
        null_buildings: [],
        offices_building: [],
        goods_buildings: [],
        canCancel: ["escape"],
        isModalActive: false,
        isModalActiveShow: false,
        isModalActiveEdit: false,
        selected: null,
        null_active: 0,
        des_active: 1,
        pendiing_good: 2,
        current: null,
      };
    },
      components:{
      NewBuilding,
      EditBuilding,
          ShowBuilding},
          props: ["buildingId"],
    methods: {


          async get_user_actual() {
        const response = await axios.get("/duty_managers/currentuser.json");
        this.current = response.data.current_user;
        this.getbuildingactive(this.current);
        console.log(this.current);
      },
  
             async getbuildingactive(item) {
        const response = await axios.get("/buildings/showbuildinguser/" + item + ".json");
        this.buildings = response.data;
      },
  
          async null_getbuilding() {
        const response = await axios.get("/buildings/shownullbuilding.json");
        this.null_buildings = response.data;
      },
  
       async AnulClick(item) {
        const response = await axios.put("/buildings/" + item + ".json", {
          active_building: this.null_active,
        });
        window.location.href = "/buildings";
      },
  
      async RestClick(item) {
        const response = await axios.put("/buildings/" + item + ".json", {
          active_building: this.des_active,
        });
        window.location.href = "/buildings";
      },
      confirmGoodRest(item) {
        this.$buefy.dialog.confirm({
          title: "Restaurar Edificio",
          message: "¿Esta seguro de querer restaurar el Edificio?.",
          confirmText: "Restaurar",
          cancelText: "Cancelar",
          type: "is-danger",
          hasIcon: true,
          onConfirm: () => this.RestClick(item),
        });
      },
  
      confirmGoodNull(item) {
        this.$buefy.dialog.confirm({
          title: "Anular Edificio",
          message: "¿Esta seguro de querer anular el Edificio?.",
          confirmText: "Anular",
          cancelText: "Cancelar",
          type: "is-danger",
          hasIcon: true,
          onConfirm: () => this.AnulClick(item),
        });
      },
  
  
      confirmisempty(item){
        this.getofficebybuilding(item);
      },
  
  
      async getofficebybuilding(item) {
        const response = await axios.get(
          "/offices/showofficebuilding/" + item + ".json"
          );
        this.offices_building = response.data;
        console.log(this.isModalActiveShow);
        console.log(this.offices_building);
        if (this.offices_building.length == 0) {
          console.log(this.offices_building.length);
          this.getgoodbybuilding(item);
          }
          else{
            this.$buefy.dialog.alert({
                      title: 'No se puede anular',
                      type: 'is-danger',
                      message: 'Existen dependencias designados en el edificio',
                      confirmText: 'Aceptar'
                  })
          }
      },
  
      async getgoodbybuilding(item) {
        const response = await axios.get("/goods/showgoodbuilding/" + item + ".json");
        this.goods_buildings = response.data;
        console.log(this.goods_buildings);
        if (this.goods_buildings.length == 0) {
          console.log(this.goods_buildings.length);
          this.confirmGoodNull(item);
          }
          else{
            this.$buefy.dialog.alert({
                      title: 'No se puede anular',
                      type: 'is-danger',
                      message: 'Existen bienes designados en el edificio',
                      confirmText: 'Aceptar'
                  })
          }
      },
  
  
  
          async Clicknewbuilding() {
        const response = (window.location.href = "/buildings/new");
      },
          async Clickshowbuilding(item) {
        const response = (window.location.href = "/buildings/mybuilding/" + item );
      },
       async Clickshowdutymanager(item) {
        const response = (window.location.href = "/duty_managers/" + item );
      },
         async Clickshowunit(item) {
        const response = (window.location.href = "/units/" + item);
      },
      async createBuilding(){
        this.isModalActive = true;
      },
      async closeModalCreate(){
        this.isModalActive = false;
      },
          async ShowModaleBuilding(item) {
        this.selected = item;
        this.isModalActiveShow = true;
      },
      async closeModalShow() {
        this.isModalActiveShow = false;
      },
  
  
  
      async AnulClickgood(item) {
        const response = await axios.put("/goods/" + item + ".json", {
          activegood: this.pendiing_good,
        });
      },
      async AnulClickoffice(item) {
        const response = await axios.put("/offices/" + item + ".json", {
          active_office: this.null_active,
        });
      },
      async editBuilding(item) {
        this.selected = item;
        this.isModalActiveEdit = true;
      },
      async closeModalEdit() {
        this.isModalActiveEdit = false;
      },
  
  
    },
    created() {
      this.get_user_actual();
    },
  };
  </script>
  
  